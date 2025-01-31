import os
import logging
from typing import List, Dict, Any
from dotenv import load_dotenv
from langchain_openai import OpenAIEmbeddings
from langchain_pinecone import PineconeVectorStore

# Load environment variables
load_dotenv()

# Configure logging with emojis
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s %(message)s',
    datefmt='%Y-%m-%d %H:%M:%S'
)
logger = logging.getLogger(__name__)

class RAGSearch:
    def __init__(self, index_name: str = "zoom-transcripts"):
        """Initialize RAG with Pinecone vector store.
        
        Args:
            index_name (str): Name of the Pinecone index to use
        """
        try:
            logger.info("🔌 Initializing RAG with Pinecone connection...")
            self.embeddings = OpenAIEmbeddings(
                model="text-embedding-3-large"
            )
            self.vector_store = PineconeVectorStore(
                index_name=index_name,
                embedding=self.embeddings
            )
            logger.info("✅ Successfully connected to Pinecone index: %s", index_name)
        except Exception as e:
            logger.error("❌ Failed to initialize RAG: %s", str(e))
            raise

    def search(self, query: str, top_k: int = 3) -> List[Dict[str, Any]]:
        """Search for relevant documents using similarity search.
        
        Args:
            query (str): The search query
            top_k (int): Number of results to return
            
        Returns:
            List[Dict]: List of documents with their content and metadata
        """
        try:
            logger.info("🔍 Searching for: '%s'", query)
            
            # Perform similarity search
            results = self.vector_store.similarity_search_with_score(
                query=query,
                k=top_k
            )
            
            # Format results
            formatted_results = []
            for doc, score in results:
                formatted_results.append({
                    "content": doc.page_content,
                    "metadata": doc.metadata,
                    "similarity_score": score
                })
            
            logger.info("✨ Found %d relevant documents", len(formatted_results))
            return formatted_results
            
        except Exception as e:
            logger.error("❌ Search failed: %s", str(e))
            raise

def get_rag_response(query: str, top_k: int = 3) -> List[Dict[str, Any]]:
    """Convenience function to get RAG search results.
    
    Args:
        query (str): The search query
        top_k (int): Number of results to return
        
    Returns:
        List[Dict]: List of relevant documents with their content and metadata
    """
    try:
        rag = RAGSearch()
        return rag.search(query=query, top_k=top_k)
    except Exception as e:
        logger.error("❌ Failed to get RAG response: %s", str(e))
        raise
