# Querying And Get Data from Chroma Collections

# Query and Get Data from Chroma Collections

Chroma collections can be queried in a variety of ways, using the `.query` method.

You can query by a set of `query embeddings`.

```python
collection.query(
    query_embeddings=[[11.1, 12.1, 13.1],[1.1, 2.3, 3.2], ...],
    n_results=10,
    where={"metadata_field": "is_equal_to_this"},
    where_document={"$contains":"search_string"}
)
```

```typescript
const result = await collection.query({
    queryEmbeddings: [[11.1, 12.1, 13.1],[1.1, 2.3, 3.2], ...],
    nResults: 10,
    where: {"metadata_field": "is_equal_to_this"},
})
```

The query will return the `n results` closest matches to each `query embedding`, in order.
An optional `where` filter dictionary can be supplied to filter by the `metadata` associated with each document.
Additionally, an optional `where document` filter dictionary can be supplied to filter by contents of the document.

If the supplied `query embeddings` are not the same dimension as the collection, an exception will be raised.

You can also query by a set of `query texts`. Chroma will first embed each `query text` with the collection's embedding function, and then perform the query with the generated embedding.

```python
collection.query(
    query_texts=["doc10", "thus spake zarathustra", ...],
    n_results=10,
    where={"metadata_field": "is_equal_to_this"},
    where_document={"$contains":"search_string"}
)
```

```typescript
await collection.query({
    queryTexts: ["doc10", "thus spake zarathustra", ...],
    nResults: 10,
    where: {"metadata_field": "is_equal_to_this"},
    whereDocument: {"$contains": "search_string"}
})
```

You can also retrieve items from a collection by `id` using `.get`.

```python
collection.get(
	ids=["id1", "id2", "id3", ...],
	where={"style": "style1"}
)
```

```typescript
await collection.get( {
    ids: ["id1", "id2", "id3", ...],
    where: {"style": "style1"}
})
```

`.get` also supports the `where` and `where document` filters. If no `ids` are supplied, it will return all items in the collection that match the `where` and `where document` filters.

### Choosing Which Data is Returned

When using get or query you can use the `include` parameter to specify which data you want returned - any of `embeddings`, `documents`, `metadatas`, and for query, `distances`. By default, Chroma will return the `documents`, `metadatas` and in the case of query, the `distances` of the results. `embeddings` are excluded by default for performance and the `ids` are always returned. You can specify which of these you want returned by passing an array of included field names to the includes parameter of the query or get method. Note that embeddings will be returned as a 2-d numpy array in `.get` and a python list of 2-d numpy arrays in `.query`.

```python
# Only get documents and ids
collection.get(
    include=["documents"]
)

collection.query(
    query_embeddings=[[11.1, 12.1, 13.1],[1.1, 2.3, 3.2], ...],
    include=["documents"]
)
```

```typescript
// Only get documents and ids
await collection.get({
    include: ["documents"]
})

await collection.query({
    query_embeddings: [[11.1, 12.1, 13.1], [1.1, 2.3, 3.2], ...],
    include: ["documents"]
})
```

# Metadata Filtering

# Metadata Filtering

Chroma supports filtering queries by `metadata` and `document` contents. The `where` filter is used to filter by `metadata`.

In order to filter on metadata, you must supply a `where` filter dictionary to the query. The dictionary must have the following structure:

```python
{
    "metadata_field": {
        <Operator>: <Value>
    }
}
```

Filtering metadata supports the following operators:

- `$eq` - equal to (string, int, float)
- `$ne` - not equal to (string, int, float)
- `$gt` - greater than (int, float)
- `$gte` - greater than or equal to (int, float)
- `$lt` - less than (int, float)
- `$lte` - less than or equal to (int, float)

Using the `$eq` operator is equivalent to using the `where` filter.

```python
{
    "metadata_field": "search_string"
}

# is equivalent to

{
    "metadata_field": {
        "$eq": "search_string"
    }
}
```

**Note**: Where filters only search embeddings where the key exists. If you search `collection.get(where={"version": {"$ne": 1}})`. Metadata that does not have the key `version` will not be returned.

#### Using logical operators

You can also use the logical operators `$and` and `$or` to combine multiple filters.

An `$and` operator will return results that match all of the filters in the list.

```python
{
    "$and": [
        {
            "metadata_field": {
                <Operator>: <Value>
            }
        },
        {
            "metadata_field": {
                <Operator>: <Value>
            }
        }
    ]
}
```

An `$or` operator will return results that match any of the filters in the list.

```python
{
    "$or": [
        {
            "metadata_field": {
                <Operator>: <Value>
            }
        },
        {
            "metadata_field": {
                <Operator>: <Value>
            }
        }
    ]
}
```

#### Using inclusion operators (`$in` and `$nin`)

The following inclusion operators are supported:

- `$in` - a value is in predefined list (string, int, float, bool)
- `$nin` - a value is not in predefined list (string, int, float, bool)

An `$in` operator will return results where the metadata attribute is part of a provided list:

```json
{
  "metadata_field": {
    "$in": ["value1", "value2", "value3"]
  }
}
```

An `$nin` operator will return results where the metadata attribute is not part of a provided list:

```json
{
  "metadata_field": {
    "$nin": ["value1", "value2", "value3"]
  }
}
```

**Tip**: For additional examples and a demo how to use the inclusion operators, please see provided notebook [here](https://github.com/chroma-core/chroma/blob/main/examples/basic_functionality/in_not_in_filtering.ipynb)

# Full Text Search

# Full Text Search

In order to filter on document contents, you must supply a `where_document` filter dictionary to the query. We support two filtering keys: `$contains` and `$not_contains`. The dictionary must have the following structure:

```python
# Filtering for a search_string
{
    "$contains": "search_string"
}

# Filtering for not contains
{
    "$not_contains": "search_string"
}
```

You can combine full-text search with Chroma's metadata filtering.

```python
collection.query(
    query_texts=["doc10", "thus spake zarathustra", ...],
    n_results=10,
    where={"metadata_field": "is_equal_to_this"},
    where_document={"$contains":"search_string"}
)
```

```typescript
await collection.query({
    queryTexts: ["doc10", "thus spake zarathustra", ...],
    nResults: 10,
    where: {"metadata_field": "is_equal_to_this"},
    whereDocument: {"$contains": "search_string"}
})
