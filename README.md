# README

Book searcher is an API wrapper for the [Open Library Search API](https://openlibrary.org/dev/docs/api/search). It exposes the search endpoint via:

```
POST https://aqueous-caverns-66351.herokuapp.com/library/search
Content-Type: application/json
{"query": "bugs"}
```

This will return the `id` which can later be used for accessing the search results. The link to the documents returned from the search will appear as the `documents` link.

Sample response:

```
{
  "data": {
    "id": "4",
    "type": "searches",
    "attributes": {
      "url": "http://openlibrary.org/search.json?q=bugs",
      "links": [
        {
          "rel": "documents",
          "href": "http://aqueous-caverns-66351.herokuapp.com/library/search/4/documents"
        }
      ]
    }
  }
}
```

The search documents endpoint can be filtered sorted and paginated. Some examples:

```
GET http://aqueous-caverns-66351.herokuapp.com/library/search/47/documents
Content-Type: application/json
{"filter_key": "author_name",
 "filter_value": "Kaufman",
 "sort_key": "title", "sort_dir": "desc"}
```

With pagination:

```
GET http://aqueous-caverns-66351.herokuapp.com/library/search/47/documents
Content-Type: application/json
{"filter_key": "author_name",
 "filter_value": "Kaufman",
 "page_size": 100, "page": 2}
```

