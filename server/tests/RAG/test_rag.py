import pytest
from app.RAG.rag import get_rag_response

def test_basic_search():
    """Test that we can get at least one result from the vector database"""
    # Run a basic search query
    results = get_rag_response(query="meeting", top_k=1)
    
    # Print the results
    print("\n🔍 Search Results:")
    for i, result in enumerate(results, 1):
        print(f"\n📄 Result {i}:")
        print(f"Content: {result['content']}")
        print(f"Metadata: {result['metadata']}")
        print(f"Similarity Score: {result['similarity_score']}\n")
    
    # Assert we got at least one result
    assert len(results) > 0
    
    # Assert the result has the expected structure
    result = results[0]
    assert "content" in result
    assert "metadata" in result
    assert "similarity_score" in result
