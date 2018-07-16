# SharinPix Import

### Code usage

#### Installation
```sh
$ npm install -g --save sharinpix-import
```

#### Usage

```sh
$ npm install -g sharinpix-import
```

```sh
$ sharinpix-import albums.csv > success.csv 2> error.csv
```

- ``` albums.csv ``` refers to the  path of the file containing the images to be imported.
-  ``` success.csv ``` refers to the path of the log file containing only successfully-imported images.
-  ``` error.csv ``` refers to the path of the error log file containing only images that failed to be imported.

The structure of the ``` albums.csv ``` file should be in the following form:

{"key":"value"} are metadatas to add to the images (as a json hash).

```
album_id_1;image_url_1;tag1,tag2,tag3;{"key":"value"}
album_id_2;image_url_2;tag1,tag2,tag3;{"key":"value"}
```
#### Example
```
000000000000000000;http://lorempixel.com/400/200/sports/;foo,bar,dim;{"key":"value"}
```
License
----

MIT
