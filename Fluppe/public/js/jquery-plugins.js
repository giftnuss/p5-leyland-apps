function say(msg) {
    console.log(msg);
}
/*
 * jQuery Cookie Plugin 1.3.1
 * https://github.com/blueimp/jQuery-Cookie
 *
 * Copyright 2010, Sebastian Tschan
 * https://blueimp.net
 *
 * Licensed under the MIT license:
 * http://creativecommons.org/licenses/MIT/
 *
 * Based on
 * Cookie plugin
 * Copyright (c) 2006 Klaus Hartl (stilbuero.de)
 * http://plugins.jquery.com/files/jquery.cookie.js.txt
 */

/*jslint unparam: true */
/*global document, jQuery */

(function ($) {
    'use strict';
    
    var getCookie = function (key, options) {
            options = options || {};
            var result = new RegExp('(?:^|; )' + encodeURIComponent(key) +
                    '=([^;]*)').exec(document.cookie),
                decode = options.raw ? String : decodeURIComponent;
            return result !== null ? decode(result[1]) : null;
        },
        
        getCookies = function (options) {
            var cookies = document.cookie.split('; '),
                list = [];
            $.each(cookies, function (index, cookie) {
                var name = cookie.split('=')[0];
                if (name) {
                    list.push({name: name, value: getCookie(name, options)});
                }
            });
            return list;
        },

        setCookie = function (key, value, options) {
            options = options || {};
            if ($.type(options.path) === 'undefined') {
                options.path = '/';
            }
            if (value === null) {
                options.expires = -1;
                value = '';
            }
            if ($.type(options.expires) === 'number') {
                var days = options.expires;
                options.expires = new Date();
                options.expires.setDate(options.expires.getDate() + days);
            }
            return (document.cookie = [
                encodeURIComponent(key), '=',
                options.raw ? String(value) : encodeURIComponent(String(value)),
                options.expires ? '; expires=' + options.expires.toUTCString() : '',
                options.path ? '; path=' + options.path : '',
                options.domain ? '; domain=' + options.domain : '',
                options.secure ? '; secure' : ''
            ].join(''));
        };
    
    $.cookie = function (key, value, options) {
        if (arguments.length === 0 || $.type(key) === 'object') {
            return getCookies(key);
        }
        if (arguments.length > 1 && (value === null || $.type(value) !== 'object')) {
            return setCookie(key, value, options);
        }
        return getCookie(key, value);
    };

}(jQuery));

/*!
jQuery Waypoints - v1.1.1
Copyright (c) 2011 Caleb Troughton
Dual licensed under the MIT license and GPL license.
https://github.com/imakewebthings/jquery-waypoints/blob/master/MIT-license.txt
https://github.com/imakewebthings/jquery-waypoints/blob/master/GPL-license.txt
*/

(function($, wp, wps, window, undefined){
	'$:nomunge';
	
	var $w = $(window),
	eventName = 'waypoint.reached',

	triggerWaypoint = function(way, dir) {
		way.element.trigger(eventName, dir);
		if (way.options.triggerOnce) {
			way.element[wp]('destroy');
		}
	},

	waypointIndex = function(el, context) {
		var i = context.waypoints.length - 1;
		while (i >= 0 && context.waypoints[i].element[0] !== el[0]) {
			i -= 1;
		}
		return i;
	},
	contexts = [],

	Context = function(context) {
		$.extend(this, {
			'element': $(context),
			'oldScroll': -99999,
			'waypoints': [],
			
			didScroll: false,
			didResize: false,
	
			doScroll: $.proxy(function() {
				var newScroll = this.element.scrollTop(),
				isDown = newScroll > this.oldScroll,
				that = this,
				pointsHit = $.grep(this.waypoints, function(el, i) {
					return isDown ?
						(el.offset > that.oldScroll && el.offset <= newScroll) :
						(el.offset <= that.oldScroll && el.offset > newScroll);
				}),
				len = pointsHit.length;
				
				// iOS adjustment
				if (!this.oldScroll || !newScroll) {
					$[wps]('refresh');
				}

				// Done with scroll comparisons, store new scroll before ejection
				this.oldScroll = newScroll;

				// No waypoints crossed? Eject.
				if (!len) return;

				// If several waypoints triggered, need to do so in reverse order going up
				if (!isDown) pointsHit.reverse();

				/*
				One scroll move may cross several waypoints.  If the waypoint's continuous
				option is true it should fire even if it isn't the last waypoint.  If false,
				it will only fire if it's the last one.
				*/
				$.each(pointsHit, function(i, point) {
					if (point.options.continuous || i === len - 1) {
						triggerWaypoint(point, [isDown ? 'down' : 'up']);
					}
				});
			}, this)
		});
		
		// Setup scroll and resize handlers.  Throttled at the settings-defined rate limits.
		$(context).scroll($.proxy(function() {
			if (!this.didScroll) {
				this.didScroll = true;
				window.setTimeout($.proxy(function() {
					this.doScroll();
					this.didScroll = false;
				}, this), $[wps].settings.scrollThrottle);
			}
		}, this)).resize($.proxy(function() {
			if (!this.didResize) {
				this.didResize = true;
				window.setTimeout($.proxy(function() {
					$[wps]('refresh');
					this.didResize = false;
				}, this), $[wps].settings.resizeThrottle);
			}
		}, this));
		
		$w.load($.proxy(function() {
			this.doScroll();
		}, this));
	},

	getContextByElement = function(element) {
		var found = null;
		
		$.each(contexts, function(i, c) {
			if (c.element[0] === element) {
				found = c;
				return false;
			}
		});
		
		return found;
	},
	
	// Methods exposed to the effin' object 
	methods = {
		init: function(f, options) {
			// Register each element as a waypoint, add to array.
			this.each(function() {
				var cElement = $.fn[wp].defaults.context,
				context,
				$this = $(this);

				// Default window context or a specific element?
				if (options && options.context) {
					cElement = options.context;
				}

				// Find the closest element that matches the context
				if (!$.isWindow(cElement)) {
					cElement = $this.closest(cElement)[0];
				}
				context = getContextByElement(cElement);

				// Not a context yet? Create and push.
				if (!context) {
					context = new Context(cElement);
					contexts.push(context);
				}
				
				// Extend default and preexisting options
				var ndx = waypointIndex($this, context),
				base = ndx < 0 ? $.fn[wp].defaults : context.waypoints[ndx].options,
				opts = $.extend({}, base, options);
				
				// Offset aliases
				opts.offset = opts.offset === "bottom-in-view" ?
					function() {
						var cHeight = $.isWindow(cElement) ? $[wps]('viewportHeight')
							: $(cElement).height();
						return cHeight - $(this).outerHeight();
					} : opts.offset;

				// Update, or create new waypoint
				if (ndx < 0) {
					context.waypoints.push({
						'element': $this,
						'offset': null,
						'options': opts
					});
				}
				else {
					context.waypoints[ndx].options = opts;
				}
				
				// Bind the function if it was passed in.
				if (f) {
					$this.bind(eventName, f);
				}
			});
			
			// Need to re-sort+refresh the waypoints array after new elements are added.
			$[wps]('refresh');
			
			return this;
		},
		
		remove: function() {
			return this.each(function(i, el) {
				var $el = $(el);
				
				$.each(contexts, function(i, c) {
					var ndx = waypointIndex($el, c);

					if (ndx >= 0) {
						c.waypoints.splice(ndx, 1);
					}
				});
			});
		},

		destroy: function() {
			return this.unbind(eventName)[wp]('remove');
		}
	},

	jQMethods = {
		refresh: function() {
			$.each(contexts, function(i, c) {
				var isWin = $.isWindow(c.element[0]),
				contextOffset = isWin ? 0 : c.element.offset().top,
				contextHeight = isWin ? $[wps]('viewportHeight') : c.element.height(),
				contextScroll = isWin ? 0 : c.element.scrollTop();
				
				$.each(c.waypoints, function(j, o) {
					// Adjustment is just the offset if it's a px value
					var adjustment = o.options.offset,
					oldOffset = o.offset;
					
					// Set adjustment to the return value if offset is a function.
					if (typeof o.options.offset === "function") {
						adjustment = o.options.offset.apply(o.element);
					}
					// Calculate the adjustment if offset is a percentage.
					else if (typeof o.options.offset === "string") {
						var amount = parseFloat(o.options.offset);
						adjustment = o.options.offset.indexOf("%") ?
							Math.ceil(contextHeight * (amount / 100)) : amount;
					}

					/* 
					Set the element offset to the window scroll offset, less
					all our adjustments.
					*/
					o.offset = o.element.offset().top - contextOffset
						+ contextScroll - adjustment;

					/*
					An element offset change across the current scroll point triggers
					the event, just as if we scrolled past it unless prevented by an
					optional flag.
					*/
					if (o.options.onlyOnScroll) return;
					
					if (oldOffset !== null && c.oldScroll > oldOffset && c.oldScroll <= o.offset) {
						triggerWaypoint(o, ['up']);
					}
					else if (oldOffset !== null && c.oldScroll < oldOffset && c.oldScroll >= o.offset) {
						triggerWaypoint(o, ['down']);
					}
				});
				
				// Keep waypoints sorted by offset value.
				c.waypoints.sort(function(a, b) {
					return a.offset - b.offset;
				});
			});
		},

		viewportHeight: function() {
			return (window.innerHeight ? window.innerHeight : $w.height());
		},

		aggregate: function() {
			var points = $();
			$.each(contexts, function(i, c) {
				$.each(c.waypoints, function(i, e) {
					points = points.add(e.element);
				});
			});
			return points;
		}
	};

	$.fn[wp] = function(method) {
		
		if (methods[method]) {
			return methods[method].apply(this, Array.prototype.slice.call(arguments, 1));
		}
		else if (typeof method === "function" || !method) {
			return methods.init.apply(this, arguments);
		}
		else if (typeof method === "object") {
			return methods.init.apply(this, [null, method]);
		}
		else {
			$.error( 'Method ' +  method + ' does not exist on jQuery ' + wp );
		}
	};
	
	$.fn[wp].defaults = {
		continuous: true,
		offset: 0,
		triggerOnce: false,
		context: window
	};

	$[wps] = function(method) {
		if (jQMethods[method]) {
			return jQMethods[method].apply(this);
		}
		else {
			return jQMethods['aggregate']();
		}
	};

	$[wps].settings = {
		resizeThrottle: 200,
		scrollThrottle: 100
	};
	
	$w.load(function() {
		// Calculate everything once on load.
		$[wps]('refresh');
	});
})(jQuery, 'waypoint', 'waypoints', this);

/* --- */

/*
 * jQuery tipi plugin
 *
 * Copyright 2011, Sebastian Knapp
 *
 * Licensed under same license terms as jquery version 1.6.1.
 */

(function ($) {
    $.fn.tipi = function(options) {
        if(!options) {
            return this;
        }
        var self = this;
        return this.each(function() {
            for(var key in options) {
                if(self[key]) {
                    for(var pos in options[key]) {
                        $('li:eq(' + pos + ')').bind(key,options[key][pos]); 
                    }  
                }
            }            
        });
    };
})(jQuery);


/*
 * jQuery xina plugin
 *
 * Copyright 2011, Sebastian Knapp
 *
 * Licensed under same license terms as jquery version 1.6.1.
 */

(function ($) {
    var defaults = {
        startvisible: false,
        spawn: false,

        display: function(win) {
            var bw = screen.availHeight;
            // var bh = screen.availWidth;
            var ww = $(win).outerWidth();
            var wh = $(win).outerHeight();
            var cx = Math.floor(bw / 2);
            // var cy = Math.floor(bh / 2);

            var r = Math.floor(Math.sqrt(Math.pow(ww / 2,2) + Math.pow(wh / 2,2)));
            var i = Math.random() * Math.PI * 1.5 + Math.PI / 4;

            var x = Math.round(cx + Math.sin(i) * r * 1.4);
            var y = Math.round(r/2 + 80 - Math.cos(i) * r/2);

            $('body').append(win);
            $(win).css({
                position: 'absolute',
                left: x,
                top: y
            }).show();
                
            
        }
    };

    function drag(ele,evt) {
         var lastX = evt.pageX;
         var lastY = evt.pageY;
         $(document).bind('mousemove.draxina',function (evt) {
             var difX = lastX - evt.pageX;
             var difY = lastY - evt.pageY;
             if(difX || difY) {
                 ele.animate({left: '-=' + difX, top: '-=' + difY},0);
                 lastX = evt.pageX;
                 lastY = evt.pageY;
             }
         });
         $(document).bind('mouseup.draxina',function (evt) {
             $(document).unbind('mousemove.draxina');
             $(document).unbind('mouseup.draxina');
         });
    }

    $.fn.xina = function(options) {
        var option = $.extend(defaults,(options || {}));
        return this.each(function () {      
            if(!option.startvisible) {
                $(this).hide();
	    }
            if(option.spawn) {
                var spawn = $(this).clone(true);
                if(option.spawn !== true) {
                    $(spawn).attr('id',option.spawn);
                }
                $('body').append(spawn);
                option.display(spawn);
            }
            else if(option.destroy) {

            }
            else{
                if($('.xina-top',this).size() == 0) {
                    var top = $('<div class="xina-top">');
                    $('.xina-top').live('mousedown',function (evt) {
                        var box = $(this).parent().parent();
                        drag(box,evt);
                    });
                    $(this).prepend(top);
                }
                if($('.xina-box',this).size() == 0) {
                    $(this).wrapInner('<div class="xina-box">');
                }
            }
        });
    };
})(jQuery);
 
/* --- */
$(function () {
    say('hello');
});
