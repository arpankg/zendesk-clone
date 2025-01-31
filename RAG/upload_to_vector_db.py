import os
import logging
from pathlib import Path
from typing import List
from dotenv import load_dotenv
from langchain_openai import OpenAIEmbeddings
from langchain_pinecone import PineconeVectorStore
from langchain.text_splitter import RecursiveCharacterTextSplitter
from langchain_community.document_loaders import DirectoryLoader, TextLoader
from langchain.schema import Document

# Load environment variables from .env file in parent directory
load_dotenv(dotenv_path=Path(__file__).parent.parent / '.env')

# Configure logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s %(message)s',
    datefmt='%Y-%m-%d %H:%M:%S'
)

logger = logging.getLogger(__name__)

class TranscriptUploader:
    def __init__(self, index_name: str):
        """Initialize the TranscriptUploader with specified Pinecone index."""
        self.index_name = index_name
        self.embeddings = OpenAIEmbeddings(
            model="text-embedding-3-large"
        )
        self.text_splitter = RecursiveCharacterTextSplitter(
            chunk_size=1000,
            chunk_overlap=100,
            separators=["\n\n", "\n", ". ", " ", ""]
        )
        
    def load_and_split_documents(self, input_dir: str) -> List:
        """Load and split documents from the input directory."""
        try:
            logger.info("🔍 Loading documents from %s", input_dir)
            loader = DirectoryLoader(
                input_dir,
                glob="**/*.txt",
                loader_cls=TextLoader
            )
            documents = loader.load()
            logger.info("📚 Loaded %d documents", len(documents))
            
            # Process each document
            chunks_with_metadata = []
            for doc in documents:
                # Extract metadata from the file
                metadata = self.extract_metadata_from_file(doc.metadata['source'])
                
                # Split document into chunks
                chunks = self.text_splitter.split_text(doc.page_content)
                
                # Add metadata to each chunk
                for i, chunk in enumerate(chunks):
                    chunks_with_metadata.append({
                        'text': chunk,
                        'metadata': {
                            **metadata,
                            'chunk_index': i
                        }
                    })
            
            logger.info("✂️  Split into %d chunks with metadata", len(chunks_with_metadata))
            return chunks_with_metadata
            
        except Exception as e:
            logger.error("❌ Error loading documents: %s", str(e))
            raise
    
    def extract_metadata_from_file(self, file_path):
        """Extract metadata from a transcript file."""
        try:
            logger.info("📋 Extracting metadata from %s", file_path)
            
            with open(file_path, 'r') as f:
                content = f.read()
            
            metadata = {
                'file_name': os.path.basename(file_path)
            }
            
            if '%START_METADATA%' in content and '%END_METADATA%' in content:
                metadata_section = content.split('%START_METADATA%')[1].split('%END_METADATA%')[0]
                for line in metadata_section.strip().split('\n'):
                    if '=' in line:
                        key, value = line.split('=')
                        metadata[key.strip()] = value.strip().strip('"')
                        
            logger.info("✨ Found metadata: %s", metadata)
            return metadata
            
        except Exception as e:
            logger.warning("⚠️  Failed to extract metadata: %s", str(e))
            return {'file_name': os.path.basename(file_path)}
    
    def upload_to_pinecone(self, documents: List) -> None:
        """Upload document chunks to Pinecone."""
        try:
            logger.info("🚀 Starting upload to Pinecone index: %s", self.index_name)
            
            # Upload documents to Pinecone
            PineconeVectorStore.from_documents(
                documents=[Document(page_content=doc['text'], metadata=doc['metadata']) for doc in documents],
                embedding=self.embeddings,
                index_name=self.index_name
            )
            
            logger.info("✅ Successfully uploaded %d documents to Pinecone", len(documents))
            
        except Exception as e:
            logger.error("❌ Error uploading to Pinecone: %s", str(e))
            raise

def main():
    # Check for required environment variables
    required_env_vars = ["OPENAI_API_KEY", "PINECONE_API_KEY"]
    missing_vars = [var for var in required_env_vars if not os.getenv(var)]
    
    if missing_vars:
        logger.error("❌ Missing required environment variables: %s", ", ".join(missing_vars))
        return
    
    try:
        # Initialize uploader with your Pinecone index name
        # You'll need to replace 'your-index-name' with your actual index name
        uploader = TranscriptUploader(index_name="gauntlet-zoom-transcripts")
        
        # Set input directory for cleaned transcripts
        input_dir = Path(__file__).parent / "cleaned zoom transcripts"
        
        # Load and split documents
        chunks = uploader.load_and_split_documents(str(input_dir))
        
        # Upload to Pinecone
        uploader.upload_to_pinecone(chunks)
        
    except Exception as e:
        logger.error("❌ Process failed: %s", str(e))
        raise

if __name__ == "__main__":
    main()