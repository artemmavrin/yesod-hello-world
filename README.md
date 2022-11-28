# yesod-hello-world

[![docs](https://github.com/artemmavrin/yesod-hello-world/actions/workflows/doc.yml/badge.svg)](https://artemmavrin.github.io/yesod-hello-world)

This is a simple application built to learn the [Yesod](https://www.yesodweb.com/) Haskell web framework.

## Run Server

Start the server locally at [`http://localhost:3000`](http://localhost:3000) using
```text
stack run
```

## Request/response examples

Valid routes are defined at [`config/routes.yesodroutes`](config/routes.yesodroutes).
The default response type is JSON, but HTML is also supported by using the [`Accept` content negotiation header field](https://www.rfc-editor.org/rfc/rfc9110.html#name-content-negotiation-fields).

### `/ GET`

* Request:
  ```bash
  curl http://localhost:3000
  ```
  Response:
  ```json
  {"greeting":"Hello, World!"}
  ```
* Request:
  ```bash
  curl 'http://localhost:3000/?name=Artem'
  ```
  Response:
  ```json
  {"greeting":"Hello, Artem!"}
  ```
* Request:
  ```bash
  curl http://localhost:3000 -H 'Accept: text/html'
  ```
  Response:
  ```html
  <!DOCTYPE html>
  <html><head><title></title></head><body>Hello, World!</body></html>
  ```
* Request:
  ```bash
  curl 'http://localhost:3000/?name=Artem' -H 'Accept: text/html'
  ```
  Response:
  ```html
  <!DOCTYPE html>
  <html><head><title></title></head><body>Hello, Artem!</body></html>
  ```

### `/ POST`

* Request:
  ```bash
  curl -X POST http://localhost:3000 -H 'Content-Type: application/json' -d '{"name":"Artem"}'
  ```
  Response:
  ```json
  {"greeting":"Hello, Artem!"}
  ```
* Request:
  ```bash
  curl -X POST http://localhost:3000 -H 'Content-Type: application/json' -d '{"name":"Artem"}' -H 'Accept: text/html'
  ```
  Response:
  ```html
  <!DOCTYPE html>
  <html><head><title></title></head><body>Hello, Artem!</body></html>
  ```

### `/{name} GET`

* Request:
  ```bash
  curl 'http://localhost:3000/Artem'
  ```
  Response:
  ```json
  {"greeting":"Hello, Artem!"}
  ```
* Request:
  ```bash
  curl 'http://localhost:3000/Artem' -H 'Accept: text/html'
  ```
  Response:
  ```html
  <!DOCTYPE html>
  <html><head><title></title></head><body>Hello, Artem!</body></html>
  ```
