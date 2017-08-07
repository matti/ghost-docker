// jscs:disable requireMultipleVarDecl

'use strict';

var Promise = require('/app/versions/1.0.0-rc.1/node_modules/bluebird'),
    StorageBase = require('/app/versions/1.0.0-rc.1/node_modules/ghost-storage-base'),
    imgur = require('./node_modules/imgur');

class ImgurStore extends StorageBase {
    constructor() {
        super();
    }

    save(image) {
      // TODO: save delete url
      return new Promise(function(resolve, reject) {
        imgur.uploadFile(image.path)
          .then(function(json) {
            if(!json || !json.data || !json.data.link) return reject();
            resolve(json.data.link);
          })
          .catch(reject);
      });
    }

    exists(fileName, targetDir) {
      // TODO: check file status
      return new Promise(function(resolve) {
        resolve(true);
      });
    }

    serve() {
      return function customServe(req, res, next) {
        next();
      }
    }

    delete() {
      return Promise.reject('not implemented');
    }

    read(options) {
    }
}

module.exports = ImgurStore;
