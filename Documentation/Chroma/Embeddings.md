# Embedding Functions

# Embedding Functions

Embeddings are the way to represent any kind of data, making them the perfect fit for working with all kinds of A.I-powered tools and algorithms. They can represent text, images, and soon audio and video. There are many options for creating embeddings, whether locally using an installed library, or by calling an API.

Chroma provides lightweight wrappers around popular embedding providers, making it easy to use them in your apps. You can set an embedding function when you create a Chroma collection, which will be used automatically, or you can call them directly yourself.

|                                                                                          | Python | Typescript |
|------------------------------------------------------------------------------------------|--------|------------|
| [OpenAI](../../integrations/embedding-models/openai)                                     | ✓      | ✓          |
| [Google Generative AI](../../integrations/embedding-models/google-gemini)                | ✓      | ✓          |
| [Cohere](../../integrations/embedding-models/cohere)                                     | ✓      | ✓          |
| [Hugging Face](../../integrations/embedding-models/hugging-face)                         | ✓      | -          |
| [Instructor](../../integrations/embedding-models/instructor)                             | ✓      | -          |
| [Hugging Face Embedding Server](../../integrations/embedding-models/hugging-face-server) | ✓      | ✓          |
| [Jina AI](../../integrations/embedding-models/jinaai)                                    | ✓      | ✓          |

We welcome pull requests to add new Embedding Functions to the community.

***

## Default: all-MiniLM-L6-v2

By default, Chroma uses the [Sentence Transformers](https://www.sbert.net/) `all-MiniLM-L6-v2` model to create embeddings. This embedding model can create sentence and document embeddings that can be used for a wide variety of tasks. This embedding function runs locally on your machine, and may require you download the model files (this will happen automatically).

```python
from chromadb.utils import embedding_functions
default_ef = embedding_functions.DefaultEmbeddingFunction()
```

```typescript
import { DefaultEmbeddingFunction } from "chromadb";
const defaultEF = new DefaultEmbeddingFunction();
```

Embedding functions can be linked to a collection and used whenever you call `add`, `update`, `upsert` or `query`. You can also use them directly which can be handy for debugging.

```python
val = default_ef(["foo"])
print(val) # [[0.05035809800028801, 0.0626462921500206, -0.061827320605516434...]]
```

```typescript
const val = defaultEf.generate(["foo"]);
console.log(val); // [[0.05035809800028801, 0.0626462921500206, -0.061827320605516434...]]
```

## Sentence Transformers

Chroma can also use any [Sentence Transformers](https://www.sbert.net/) model to create embeddings.

You can pass in an optional `model_name` argument, which lets you choose which Sentence Transformers model to use. By default, Chroma uses `all-MiniLM-L6-v2`. You can see a list of all available models [here](https://www.sbert.net/docs/pretrained_models.html).

```python
sentence_transformer_ef = embedding_functions.SentenceTransformerEmbeddingFunction(
    model_name="all-MiniLM-L6-v2"
)
```

```typescript
import { DefaultEmbeddingFunction } from "chromadb";
const modelName = "all-MiniLM-L6-v2";
const defaultEF = new DefaultEmbeddingFunction(modelName);
```

## Custom Embedding Functions

You can create your own embedding function to use with Chroma, it just needs to implement the `EmbeddingFunction` protocol.

```python
from chromadb import Documents, EmbeddingFunction, Embeddings

class MyEmbeddingFunction(EmbeddingFunction):
    def __call__(self, input: Documents) -> Embeddings:
        # embed the documents somehow
        return embeddings
```

```typescript
class MyEmbeddingFunction {
    private api_key: string;

    constructor(api_key: string) {
        this.api_key = api_key;
    }

    public async generate(texts: string[]): Promise<number[][]> {
        // do things to turn texts into embeddings with an api_key perhaps
        return embeddings;
    }
}
```

We welcome contributions! If you create an embedding function that you think would be useful to others, please consider [submitting a pull request](https://github.com/chroma-core/chroma) to add it to Chroma's `embedding_functions` module.

# Multimodal

# Multimodal

**Note**: Multimodal support is currently available only in Python. Javascript/Typescript support coming soon!

Chroma supports multimodal collections, i.e. collections which can store, and can be queried by, multiple modalities of data.

[Try it out in Colab](https://githubtocolab.com/chroma-core/chroma/blob/main/examples/multimodal/multimodal_retrieval.ipynb)

## Multi-modal Embedding Functions

Chroma supports multi-modal embedding functions, which can be used to embed data from multiple modalities into a single embedding space.

Chroma has the OpenCLIP embedding function built in, which supports both text and images.

```python
from chromadb.utils.embedding_functions import OpenCLIPEmbeddingFunction
embedding_function = OpenCLIPEmbeddingFunction()
```

## Data Loaders

Chroma supports data loaders, for storing and querying with data stored outside Chroma itself, via URI. Chroma will not store this data, but will instead store the URI, and load the data from the URI when needed.

Chroma has a data loader for loading images from a filesystem built in.

```python
from chromadb.utils.data_loaders import ImageLoader
data_loader = ImageLoader()
```

## Multi-modal Collections

You can create a multi-modal collection by passing in a multi-modal embedding function. In order to load data from a URI, you must also pass in a data loader.

```python
import chromadb

client = chromadb.Client()

collection = client.create_collection(
    name='multimodal_collection',
    embedding_function=embedding_function,
    data_loader=data_loader)
```

### Adding data

You can add data to a multi-modal collection by specifying the data modality. For now, images are supported:

```python
collection.add(
    ids=['id1', 'id2', 'id3'],
    images=[...] # A list of numpy arrays representing images
)
```

Note that Chroma will not store the data for you, and you will have to maintain a mapping from IDs to data yourself.

However, you can use Chroma in combination with data stored elsewhere, by adding it via URI. Note that this requires that you have specified a data loader when creating the collection.

```python
collection.add(
    ids=['id1', 'id2', 'id3'],
    uris=[...] #  A list of strings representing URIs to data
)
```

Since the embedding function is multi-modal, you can also add text to the same collection:

```python
collection.add(
    ids=['id4', 'id5', 'id6'],
    documents=["This is a document", "This is another document", "This is a third document"]
)
```

### Querying

You can query a multi-modal collection with any of the modalities that it supports. For example, you can query with images:

```python
results = collection.query(
    query_images=[...] # A list of numpy arrays representing images
)
```

Or with text:

```python
results = collection.query(
    query_texts=["This is a query document", "This is another query document"]
)
```

If a data loader is set for the collection, you can also query with URIs which reference data stored elsewhere of the supported modalities:

```python
results = collection.query(
    query_uris=[...] # A list of strings representing URIs to data
)
```

Additionally, if a data loader is set for the collection, and URIs are available, you can include the data in the results:

```python
results = collection.query(
    query_images=[...], # # list of numpy arrays representing images
    includes=['data']
)
```

This will automatically call the data loader for any available URIs, and include the data in the results. `uris` are also available as an `includes` field.

### Updating

You can update a multi-modal collection by specifying the data modality, in the same way as `add`. For now, images are supported:

```python
collection.update(
    ids=['id1', 'id2', 'id3'],
    images=[...] # A list of numpy arrays representing images
)
```

Note that a given entry with a specific ID can only have one associated modality at a time. Updates will over-write the existing modality, so for example, an entry which originally has corresponding text and updated with an image, will no longer have that text after an update with images.
