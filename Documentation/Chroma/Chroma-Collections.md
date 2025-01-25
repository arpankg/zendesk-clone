# Create, Get, Delete

```
Create, Get, and Delete Chroma Collections
Chroma lets you manage collections of embeddings, using the collection primitive.

Chroma uses collection names in the url, so there are a few restrictions on naming them:

The length of the name must be between 3 and 63 characters.
The name must start and end with a lowercase letter or a digit, and it can contain dots, dashes, and underscores in between.
The name must not contain two consecutive dots.
The name must not be a valid IP address.
Chroma collections are created with a name and an optional embedding function.

If you supply an embedding function, you must supply it every time you get the collection.

```python
collection = client.create_collection(name="my_collection", embedding_function=emb_fn)
collection = client.get_collection(name="my_collection", embedding_function=emb_fn)
```

The embedding function takes text as input and embeds it. If no embedding function is supplied, Chroma will use sentence transformer as a default. You can learn more about embedding functions, and how to create your own.

When creating collections, you can pass the optional metadata argument to add a mapping of metadata key-value pairs to your collections. This can be useful for adding general about the collection like creation time, description of the data stored in the collection, and more.

```python
from datetime import datetime

collection = client.create_collection(
    name="my_collection", 
    embedding_function=emb_fn,
    metadata={
        "description": "my first Chroma collection",
        "created": str(datetime.now())
    }  
)
```

The collection metadata is also used to configure the embedding space of a collection. Learn more about it in Configuring Chroma Collections.

The Chroma client allows you to get and delete existing collections by their name. It also offers a get or create method to get a collection if it exists, or create it otherwise.

```python
collection = client.get_collection(name="test") # Get a collection object from an existing collection, by name. Will raise an exception if it's not found.
collection = client.get_or_create_collection(name="test") # Get a collection object from an existing collection, by name. If it doesn't exist, create it.
client.delete_collection(name="my_collection") # Delete a collection and all associated embeddings, documents, and metadata. ⚠️ This is destructive and not reversible
```

Collections have a few useful convenience methods.

peek() - returns a list of the first 10 items in the collection.
count() - returns the number of items in the collection.
modify() - rename the collection

```python
collection.peek() 
collection.count() 
collection.modify(name="new_name")
```




# Configure

# Configuring Chroma Collections

You can configure the embedding space of a collection by setting special keys on a collection's metadata. These configurations will help you customize your Chroma collections for different data, accuracy and performance requirements.

* `hnsw:space` defines the distance function of the embedding space. The default is `l2` (squared L2 norm), and other possible values are `cosine` (cosine similarity), and `ip` (inner product).

| Distance          | parameter |                                                                                                                                                   Equation |
| ----------------- | :-------: |-----------------------------------------------------------------------------------------------------------------------------------------------------------:|
| Squared L2        |   `l2`    |                                                                                                {% Latex %} d =  \\sum\\left(A_i-B_i\\right)^2 {% /Latex %} |
| Inner product     |   `ip`    |                                                                                     {% Latex %} d = 1.0 - \\sum\\left(A_i \\times B_i\\right) {% /Latex %} |
| Cosine similarity | `cosine`  | {% Latex %} d = 1.0 - \\frac{\\sum\\left(A_i \\times B_i\\right)}{\\sqrt{\\sum\\left(A_i^2\\right)} \\cdot \\sqrt{\\sum\\left(B_i^2\\right)}} {% /Latex %} |

* `hnsw:construction_ef` determines the size of the candidate list used to select neighbors during index creation. A higher value improves index quality at the cost of more memory and time, while a lower value speeds up construction with reduced accuracy. The default value is `100`.
* `hnsw:search_ef` determines the size of the dynamic candidate list used while searching for the nearest neighbors. A higher value improves recall and accuracy by exploring more potential neighbors but increases query time and computational cost, while a lower value results in faster but less accurate searches. The default value is `100`.
* `hnsw:M` is the maximum number of neighbors (connections) that each node in the graph can have during the construction of the index. A higher value results in a denser graph, leading to better recall and accuracy during searches but increases memory usage and construction time. A lower value creates a sparser graph, reducing memory usage and construction time but at the cost of lower search accuracy and recall. The default value is `16`.
* `hnsw:num_threads` specifies the number of threads to use during index construction or search operations. The default value is `multiprocessing.cpu_count()` (available CPU cores).

Here is an example of how you can create a collection and configure it with custom HNSW settings:


```python
collection = client.create_collection(
    name="my_collection", 
    embedding_function=emb_fn,
    metadata={
        "hnsw:space": "cosine",
        "hnsw:search_ef": 100
    }
)
```

```typescript
let collection = await client.createCollection({
    name: "my_collection",
    embeddingFunction: emb_fn,
    metadata: {
        "hnsw:space": "cosine",
        "hnsw:search_ef": 100
    }
});
```

You can learn more in our [Embeddings section](../embeddings/embedding-functions).

## Fine-Tuning HNSW Parameters

We use an HNSW (Hierarchical Navigable Small World) index to perform approximate nearest neighbor (ANN) search for a given embedding. In this context, **Recall** refers to how many of the true nearest neighbors were retrieved.

Increasing `search_ef` normally improves recall, but slows down query time. Similarly, increasing `construction_ef` improves recall, but increases the memory usage and runtime when creating the index.

Choosing the right values for your HNSW parameters depends on your data, embedding function, and requirements for recall, and performance. You may need to experiment with different construction and search values to find the values that meet your requirements.

For example, for a dataset with 50,000 embeddings of 2048 dimensions, generated by

```python
embeddings = np.random.randn(50000, 2048).astype(np.float32).tolist()
```

we set up two Chroma collections:
* The first is configured with `hnsw:ef_search: 10`. When querying using a specific embedding from the set (with `id = 1`), the query takes `0.00529` seconds, and we get back embeddings with distances:

```
[3629.019775390625, 3666.576904296875, 3684.57080078125]
``` 

* The second collection is configured with `hnsw:ef_search: 100` and `hnsw:ef_construction:1000`. When issuing the same query, this time it takes `0.00753` seconds (about 42% slower), but with better results as measured by their distance:

```
[0.0, 3620.593994140625, 3623.275390625]
```

In this example, when querying with the test embedding (`id=1`), the first collection failed to find the embedding itself, despite it being in the collection (where it should have appeared as a result with a distance of `0.0`). The second collection, while slightly slower, successfully found the query embedding itself (shown by the `0.0` distance) and returned closer neighbors overall, demonstrating better accuracy at the cost of performance.


# Add Data

# Adding Data to Chroma Collections

Add data to Chroma with `.add`.

Raw documents:

```python
collection.add(
    documents=["lorem ipsum...", "doc2", "doc3", ...],
    metadatas=[{"chapter": "3", "verse": "16"}, {"chapter": "3", "verse": "5"}, {"chapter": "29", "verse": "11"}, ...],
    ids=["id1", "id2", "id3", ...]
)
```
```typescript
await collection.add({
    ids: ["id1", "id2", "id3", ...],
    metadatas: [{"chapter": "3", "verse": "16"}, {"chapter": "3", "verse": "5"}, {"chapter": "29", "verse": "11"}, ...],
    documents: ["lorem ipsum...", "doc2", "doc3", ...],
});
```

If Chroma is passed a list of `documents`, it will automatically tokenize and embed them with the collection's embedding function (the default will be used if none was supplied at collection creation). Chroma will also store the `documents` themselves. If the documents are too large to embed using the chosen embedding function, an exception will be raised.

Each document must have a unique associated `id`. Trying to `.add` the same ID twice will result in only the initial value being stored. An optional list of `metadata` dictionaries can be supplied for each document, to store additional information and enable filtering.

Alternatively, you can supply a list of document-associated `embeddings` directly, and Chroma will store the associated documents without embedding them itself.

```python
collection.add(
    documents=["doc1", "doc2", "doc3", ...],
    embeddings=[[1.1, 2.3, 3.2], [4.5, 6.9, 4.4], [1.1, 2.3, 3.2], ...],
    metadatas=[{"chapter": "3", "verse": "16"}, {"chapter": "3", "verse": "5"}, {"chapter": "29", "verse": "11"}, ...],
    ids=["id1", "id2", "id3", ...]
)
```

```typescript
await collection.add({
    ids: ["id1", "id2", "id3", ...],
    embeddings: [[1.1, 2.3, 3.2], [4.5, 6.9, 4.4], [1.1, 2.3, 3.2], ...],
    metadatas: [{"chapter": "3", "verse": "16"}, {"chapter": "3", "verse": "5"}, {"chapter": "29", "verse": "11"}, ...],
    documents: ["lorem ipsum...", "doc2", "doc3", ...],
})
```

If the supplied `embeddings` are not the same dimension as the collection, an exception will be raised.

You can also store documents elsewhere, and just supply a list of `embeddings` and `metadata` to Chroma. You can use the `ids` to associate the embeddings with your documents stored elsewhere.

```python
collection.add(
    embeddings=[[1.1, 2.3, 3.2], [4.5, 6.9, 4.4], [1.1, 2.3, 3.2], ...],
    metadatas=[{"chapter": "3", "verse": "16"}, {"chapter": "3", "verse": "5"}, {"chapter": "29", "verse": "11"}, ...],
    ids=["id1", "id2", "id3", ...]
)
```

```typescript
await collection.add({
    ids: ["id1", "id2", "id3", ...],
    embeddings: [[1.1, 2.3, 3.2], [4.5, 6.9, 4.4], [1.1, 2.3, 3.2], ...],
    metadatas: [{"chapter": "3", "verse": "16"}, {"chapter": "3", "verse": "5"}, {"chapter": "29", "verse": "11"}, ...],
})
```


# Update Data

# Updating Data in Chroma Collections

Any property of records in a collection can be updated with `.update`:

```python
collection.update(
    ids=["id1", "id2", "id3", ...],
    embeddings=[[1.1, 2.3, 3.2], [4.5, 6.9, 4.4], [1.1, 2.3, 3.2], ...],
    metadatas=[{"chapter": "3", "verse": "16"}, {"chapter": "3", "verse": "5"}, {"chapter": "29", "verse": "11"}, ...],
    documents=["doc1", "doc2", "doc3", ...],
)
```

```typescript
await collection.update({
    ids: ["id1", "id2", "id3", ...], 
    embeddings: [[1.1, 2.3, 3.2], [4.5, 6.9, 4.4], [1.1, 2.3, 3.2], ...], 
    metadatas: [{"chapter": "3", "verse": "16"}, {"chapter": "3", "verse": "5"}, {"chapter": "29", "verse": "11"}, ...], 
    documents: ["doc1", "doc2", "doc3", ...]
})
```

If an `id` is not found in the collection, an error will be logged and the update will be ignored. If `documents` are supplied without corresponding `embeddings`, the embeddings will be recomputed with the collection's embedding function.

If the supplied `embeddings` are not the same dimension as the collection, an exception will be raised.

Chroma also supports an `upsert` operation, which updates existing items, or adds them if they don't yet exist.

```python
collection.upsert(
    ids=["id1", "id2", "id3", ...],
    embeddings=[[1.1, 2.3, 3.2], [4.5, 6.9, 4.4], [1.1, 2.3, 3.2], ...],
    metadatas=[{"chapter": "3", "verse": "16"}, {"chapter": "3", "verse": "5"}, {"chapter": "29", "verse": "11"}, ...],
    documents=["doc1", "doc2", "doc3", ...],
)
```

```typescript
await collection.upsert({
    ids: ["id1", "id2", "id3"],
    embeddings: [
        [1.1, 2.3, 3.2],
        [4.5, 6.9, 4.4],
        [1.1, 2.3, 3.2],
    ],
    metadatas: [
        { chapter: "3", verse: "16" },
        { chapter: "3", verse: "5" },
        { chapter: "29", verse: "11" },
    ],
    documents: ["doc1", "doc2", "doc3"],
});
```

If an `id` is not present in the collection, the corresponding items will be created as per `add`. Items with existing `id`s will be updated as per `update`.

# Delete Data

# Deleting Data from Chroma Collections

Chroma supports deleting items from a collection by `id` using `.delete`. The embeddings, documents, and metadata associated with each item will be deleted.

**Warning**: Naturally, this is a destructive operation, and cannot be undone.

`.delete` also supports the `where` filter. If no `ids` are supplied, it will delete all items in the collection that match the `where` filter.

```python
collection.delete(
    ids=["id1", "id2", "id3",...],
	where={"chapter": "20"}
)
```

```typescript
await collection.delete({
    ids: ["id1", "id2", "id3",...], //ids
    where: {"chapter": "20"} //where
})
```