# Ephemeral Client

```
Ephemeral Client
In Python, you can run a Chroma server in-memory and connect to it with the ephemeral client:

```python
import chromadb

client = chromadb.Client()
```

The `Client()` method starts a Chroma server in-memory and also returns a client with which you can connect to it.

This is a great tool for experimenting with different embedding functions and retrieval techniques in a Python notebook, for example. If you don't need data persistence, the ephemeral client is a good choice for getting up and running with Chroma.
```


# Persistent Client

```
Persistent Client
You can configure Chroma to save and load the database from your local machine, using the `PersistentClient`.

Data will be persisted automatically and loaded on start (if it exists).

```python
import chromadb

client = chromadb.PersistentClient(path="/path/to/save/to")
```

The `path` is where Chroma will store its database files on disk, and load them on start. If you don't provide a path, the default is `.chroma`

The `client` object has a few useful convenience methods.

`heartbeat()` - returns a nanosecond heartbeat. Useful for making sure the client remains connected.
`reset()` - empties and completely resets the database. ⚠️ This is destructive and not reversible.

```python
client.heartbeat()
client.reset()
```


# Client-Server Mode

Running Chroma in Client-Server Mode
=====================================

Chroma can also be configured to run in client/server mode. In this mode, the Chroma client connects to a Chroma server running in a separate process.

To start the Chroma server, run the following command:

```bash
chroma run --path /db_path
```

Then use the Chroma HTTP client to connect to the server:

```python
import chromadb

chroma_client = chromadb.HttpClient(host='localhost', port=8000)
```

That's it! Chroma's API will run in client-server mode with just this change.

Chroma also provides an async HTTP client. The behaviors and method signatures are identical to the synchronous client, but all methods that would block are now async. To use it, call `AsyncHttpClient` instead:

```python
import asyncio
import chromadb

async def main():
    client = await chromadb.AsyncHttpClient()

    collection = await client.create_collection(name="my_collection")
    await collection.add(
        documents=["hello world"],
        ids=["id1"]
    )

asyncio.run(main())
```

If you deploy your Chroma server, you can also use our http-only package.


# Python HTTP-Only Client

The Python HTTP-Only Client
============================

If you are running Chroma in client-server mode, where you run a Chroma server and client on separate machines, you may not need the full Chroma package where you run your client. Instead, you can use the lightweight client-only library. In this case, you can install the `chromadb-client` package. This package is a lightweight HTTP client for the server with a minimal dependency footprint.

On your server, install chroma with

```bash
pip install chromadb
```

And run a Chroma server:

```bash
chroma run --path [path/to/persist/data]
```

Then, on your client side, install the HTTP-only client:

```bash
pip install chromadb-client

import chromadb
# Example setup of the client to connect to your chroma server
client = chromadb.HttpClient(host='localhost', port=8000)

# Or for async usage:
async def main():
    client = await chromadb.AsyncHttpClient(host='localhost', port=8000)
```

Note that the `chromadb-client` package is a subset of the full Chroma library and does not include all the dependencies. If you want to use the full Chroma library, you can install the `chromadb` package instead. Most importantly, there is no default embedding function. If you `add()` documents without embeddings, you must have manually specified an embedding function and installed the dependencies for it.
