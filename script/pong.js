/*
 * Copyright (C) 2012 Benjamin Feng
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */


var TAU = 2*Math.PI;

/* Yet another complex number implementation. */
function Complex(real, imag, mag, dir) {
  if(!(this instanceof Complex)) { return new Complex(real, imag, mag, dir); }

  this.real = real;
  this.imag = imag;
  this.mag = mag;
  this.dir = dir;
}

$.extend(Complex, {
  rect: function(real, imag) {
    return new this(real, imag).sRecalcPolar();
  },

  polar: function(mag, dir) {
    return new this(0, 0, mag, dir).sRecalcRect();
  }
});

$.extend(Complex.prototype, {
  clone: function() {
    return new Complex(this.real, this.imag, this.mag, this.dir);
  },

  sRecalcRect: function() {
    this.real = this.mag*Math.cos(this.dir);
    this.imag = this.mag*Math.sin(this.dir);
    return this;
  },

  sRecalcPolar: function() {
    this.mag = Math.sqrt(this.real*this.real + this.imag*this.imag)
    this.dir = Math.atan2(this.imag, this.real);
    return this;
  },

  sAdd: function(c) {
    this.real += c.real;
    this.imag += c.imag;
    return this.sRecalcPolar();
  },

  sMult: function(c) {
    if(c.dir) {
      this.mag *= c.mag;
      this.dir += c.dir;
      return this.sRecalcRect();
    } else {
      var mag = c.mag || c;
      this.real *= mag;
      this.imag *= mag;
      this.mag *= mag;
      return this;
    }
  },

  sReflectReal: function(c) {
    this.real = -this.real;
    return this.sRecalcPolar();
  },

  sReflectImag: function(c) {
    this.imag = -this.imag;
    return this.sRecalcPolar();
  },

  mult: function(c) {
    return this.clone().sMult(c);
  }
});

function pong(container, fieldwidth, fieldheight, ballsize) {
  var $field = $('<div id="field" />').appendTo(container);
  $field.css('width', fieldwidth);
  $field.css('height', fieldheight);

  var $ball = $('<div class="ball" />').appendTo($field);

  var cssTransition = (function(undefined) {
    var style = (document.body || document.documentElement).style;
    return (style.WebkitTransition !== undefined ? '-webkit-transition' :
            style.MozTransition !== undefined ? '-moz-transition' :
            style.OTransition !== undefined ? '-o-transition' :
            style.transition !== undefined ? 'transition' :
            null);
  })();

  $ball.css({width:      ballsize,    height: ballsize,
             marginLeft: -ballsize/2, marginTop: -ballsize/2});

  function cssPos() {
    return {left: fieldwidth/2 + $ball.pos.real, top: fieldheight/2 - $ball.pos.imag};
  }

  var projectionId;
  function projection() {
    var horiWall = ($ball.vel.real > 0 ? 1 : -1) * (fieldwidth/2 - ballsize/2);
    var vertWall = ($ball.vel.imag > 0 ? 1 : -1) * (fieldheight/2 - ballsize/2);

    var horiSecTarget = (horiWall - $ball.pos.real) / $ball.vel.real;
    var vertSecTarget = (vertWall - $ball.pos.imag) / $ball.vel.imag;

    var secTarget;
    if(horiSecTarget < vertSecTarget) {
      secTarget = horiSecTarget;
      $ball.pos.sAdd($ball.vel.mult(secTarget));
      $ball.vel.sReflectReal();
    } else {
      secTarget = vertSecTarget;
      $ball.pos.sAdd($ball.vel.mult(secTarget));
      $ball.vel.sReflectImag();
    }
    var drawSecTarget = secTarget - 0.01;

    if(cssTransition) {
      $ball.css(cssTransition+'-duration', drawSecTarget+'s');
      $ball.css(cssPos());
    } else {
      $ball.animate(cssPos(), drawSecTarget*1000, 'linear');
    }
    projectionId = setTimeout(projection, secTarget*1000);
  }

  return {
    start: function() {
      clearTimeout(projectionId);

      $ball.pos = Complex.rect(0, -fieldheight/2);
      $ball.vel = Complex.polar(200, TAU * (4/9 - 3/9*Math.random()));
      $ball.css(cssPos());

      if(cssTransition) { $ball.css(cssTransition, 'all linear'); }
      projectionId = setTimeout(projection, 100);
    }
  };
}
