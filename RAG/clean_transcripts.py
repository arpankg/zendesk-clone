import os
import logging
from pathlib import Path
from typing import List, Dict, TextIO
from langchain_openai import ChatOpenAI
from langchain.schema import HumanMessage
from langchain.globals import set_debug, set_verbose
from langchain.text_splitter import RecursiveCharacterTextSplitter
from dotenv import load_dotenv

# Load environment variables from .env file in parent directory
load_dotenv(dotenv_path=Path(__file__).parent.parent / '.env')

# Configure logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s 📝 %(levelname)s: %(message)s',
    datefmt='%Y-%m-%d %H:%M:%S'
)

# Enable debug mode for LangChain
set_debug(True)  # This will show all raw inputs/outputs
set_verbose(True)  # This will show a more readable format

# Enable LangChain debug logging
langchain_logger = logging.getLogger("langchain")
langchain_logger.setLevel(logging.DEBUG)

logger = logging.getLogger(__name__)

# Custom prompt for cleaning text
CLEANING_PROMPT = """
You are given a snippet of a Zoom transcript. You need to fix any spelling/grammatical errors in the zoom transcript. It's from a lecture on generative AI and machine learning, so there may be mistakes around commonly used terms from ML/AI being misspelled. Other names, places, products, etc. may also be misspelled.

Here's a list of potential mistakes

e4 -> Ephor
V0 -> v0
ccat -> CCAT
brainless -> BrainLift
brainlift -> BrainLift

Here's the correct versions of other potentially misspelled terms that you should correct.

CORRECT VERSIONS
- OpenAI
- xAI
- Mistral
- Anthropic
- Claude
- Trilogy
- Trilogy University
- Joe Liemandt
- Gauntlet
- GauntletAI
- Pinecone
- Chroma
- Postgres
- Obsidian
- Workflowy
- Clerk
- YOLO mode
- PRD
- PR
- Zero-shot
- Few-shot
- spiky POV
- NextJS
- Qwen
- Claude Sonnet 3.5
- Sonnet 3.5
- Obsidian
- Roam Research
- Roam
- Thiago Forte
- Sam Altman
- Danielle
- Council of Kings

Note - this is NOT an exhaustive list. There be other terms in software engineering, system design, machine learning, deep learning, genAI, countries, places, cities, famous people, etc. that I may have missed. Please correct those as well.

You should ONLY return the corrected snippet of the transcript. DO NOT CHANGE ANYTHING OTHER THAN FIXING MISSPELLINGS/GRAMMATICAL ERRORS!!
"""

class TranscriptCleaner:
    def __init__(self, model_name: str = "gpt-4o"):
        """Initialize the TranscriptCleaner with specified model."""
        self.llm = ChatOpenAI(
            model_name=model_name,
            temperature=0.0,  # Keep it deterministic for cleaning
            max_retries=20,   # Increase number of retries
            request_timeout=20  # Set timeout to 20 seconds
        )
        self.text_splitter = RecursiveCharacterTextSplitter(
            chunk_size=1000,  # Characters per chunk
            chunk_overlap=100,  # Some overlap to maintain context
            separators=["\n\n", "\n", ". ", " ", ""]
        )
        
    def clean_chunk(self, chunk: str) -> str:
        """Clean a single chunk of text using GPT-4."""
        try:
            messages = [
                HumanMessage(content=CLEANING_PROMPT + "\n\nText Chunk:\n" + chunk)
            ]
            response = self.llm(messages)
            logger.info("🧹 Successfully cleaned chunk")
            return response.content
        except Exception as e:
            logger.error(f"❌ Error cleaning chunk: {str(e)}")
            raise

    def process_metadata(self, lines: List[str], output_file: TextIO) -> int:
        """Process and write metadata section. Returns the last line processed."""
        i = 0
        if lines[i].strip() == "%START_METADATA%":
            while i < len(lines) and lines[i].strip() != "%END_METADATA%":
                output_file.write(lines[i] + '\n')
                output_file.flush()  # Force write to disk
                i += 1
            if i < len(lines):  # Write the END_METADATA line
                output_file.write(lines[i] + '\n')
                output_file.flush()  # Force write to disk
            i += 1
            output_file.write('\n')  # Add blank line after metadata
            output_file.flush()  # Force write to disk
            logger.info("📋 Processed metadata section")
        return i

    def process_transcript(self, transcript_file: Path, output_file: Path):
        """Process the transcript file and write chunks immediately to output file."""
        logger.info(f"📖 Starting file: {transcript_file.name}")
        
        with open(transcript_file, 'r', encoding='utf-8') as f:
            lines = f.readlines()

        chunk_count = 0
        current_speaker = None
        current_text = ""
        
        # Open output file in append mode
        with open(output_file, 'w', encoding='utf-8', buffering=1) as out_f:  # Line buffered
            # Process metadata first
            i = self.process_metadata(lines, out_f)
            
            # Process the rest of the file
            while i < len(lines):
                line = lines[i].strip()
                
                # Handle speaker labels
                if line.startswith("Speaker "):
                    # Process any remaining text from previous speaker
                    if current_text:
                        chunks = self.text_splitter.split_text(current_text)
                        for chunk in chunks:
                            chunk_count += 1
                            logger.info(f"🔄 Processing chunk {chunk_count} for {current_speaker}")
                            cleaned_text = self.clean_chunk(chunk)
                            out_f.write(cleaned_text + '\n\n')
                            out_f.flush()  # Force write to disk
                            logger.info(f"💾 Wrote chunk {chunk_count} to file")
                        current_text = ""
                    
                    # Write new speaker header
                    current_speaker = line
                    out_f.write('\n---\n\n')  # Add separator before speaker
                    out_f.write(line + '\n\n')  # Write the speaker line as is
                    out_f.flush()  # Force write to disk
                    logger.info(f"👤 Starting new speaker section: {current_speaker}")
                    
                else:
                    # Add non-empty lines to current text
                    if line:
                        current_text += line + " "
                
                i += 1
            
            # Process any remaining text
            if current_text:
                chunks = self.text_splitter.split_text(current_text)
                for chunk in chunks:
                    chunk_count += 1
                    logger.info(f"🔄 Processing final chunk {chunk_count} for {current_speaker}")
                    cleaned_text = self.clean_chunk(chunk)
                    out_f.write(cleaned_text + '\n')
                    out_f.flush()  # Force write to disk
                    logger.info(f"💾 Wrote final chunk {chunk_count} to file")
        
        logger.info(f"✅ Processed {chunk_count} total chunks")

def process_transcripts(input_dir: str, output_dir: str):
    """Process all transcripts in the input directory."""
    input_path = Path(input_dir)
    output_path = Path(output_dir)
    
    # Create output directory if it doesn't exist
    output_path.mkdir(parents=True, exist_ok=True)
    logger.info(f"📁 Created output directory: {output_dir}")
    
    cleaner = TranscriptCleaner()
    
    # List all transcript files
    transcript_files = list(input_path.glob("*.txt"))
    logger.info(f"📚 Found {len(transcript_files)} transcript files to process")
    
    # Process each transcript file
    for transcript_file in transcript_files:
        try:
            cleaner.process_transcript(transcript_file, output_path / transcript_file.name)
            logger.info(f"✅ Successfully completed {transcript_file.name}")
            
        except Exception as e:
            logger.error(f"❌ Error processing {transcript_file.name}: {str(e)}")
            continue

if __name__ == "__main__":
    # Get the absolute paths
    current_dir = Path(__file__).parent
    input_directory = current_dir / "cleaned zoom transcripts"
    output_directory = input_directory / "lectures"
    
    logger.info("🚀 Starting transcript cleaning process")
    process_transcripts(input_directory, output_directory)
    logger.info("🎉 Finished transcript cleaning process")