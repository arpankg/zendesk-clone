import pytest
from app.customer_agent.rag import get_rag_response

def test_basic_search():
    """Test that we can get at least one result from the vector database"""
    # Run a basic search query
    results = get_rag_response(query="meeting", top_k=1)
    
    # Assert we got at least one result
    assert len(results) > 0
    
    # Assert the result has the expected structure
    result = results[0]
    assert "content" in result
    assert "metadata" in result
    assert "similarity_score" in result
