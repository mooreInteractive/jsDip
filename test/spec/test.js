/* global describe, it */
var should = require('should');

(function () {
    'use strict';

    describe('Truth test', function () {
        describe('maybe describe it some more here?', function () {
            it('should describe truth as true.', function () {
              true.should.be.true;
            });
            it('should describe false as not true.', function () {
              false.should.not.be.true;
            });
        });
    });
})();
