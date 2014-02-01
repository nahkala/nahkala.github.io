/*! jQuery Parallax Plugin v0.0.2 To the extent possible under law, Erik Nahkala has waived all copyright and related or neighboring rights to this software http://creativecommons.org/publicdomain/zero/1.0/ */
(function($) {

    'use strict';

    $.fn.parallax = function(action, options) {

        // If action is an object then init
        if (typeof action === 'object' || action === undefined) {
            return this.each(function() {
                $.fn.parallax.init(this, action);
            });

        // If action is a string trigger matching action
        } else if (typeof action === 'string') {
            switch (action.toLowerCase()) {
            case 'init':
                return this.each(function() {
                    $.fn.parallax.init(this, options);
                });
            case 'destroy':
                return this.each(function() {
                    $.fn.parallax.destroy(this);
                });
            case 'update':
                return this.each(function() {
                    $.fn.parallax.update(this, options);
                });

            }
        }
    };

    $.fn.parallax.init = function(target, options) {
        var $target = $(target),
            opts = $.extend({}, $.fn.parallax.defaults, options);
        
        // Save options to object data
        $target.data('parallax', opts);

        // bind scroll to update event
        $(window).on('scroll.parallax', function() {
            $target.parallax('update');
        });
    };

    $.fn.parallax.destroy = function (target) {
        var $target = $(target);

        //@todo make sure scroll.parallax events are removed on destroy.
        //@todo make sure css is reset on destroy.

        //remove data from target
        $target.removeData('parallax');
    };

    $.fn.parallax.update = function(target, options) {
        var $target = $(target),
            scrolled = $(window).scrollTop(),
            opts = $target.data('parallax');

        // Save new options to object data
        if (options !== undefined) {
            opts = $.extend({}, opts, options);
            $target.data('parallax', opts);
        }

        // Check if target should be offset
        if (scrolled < opts.start) {
            scrolled = 0;
        } else if (opts.stop > 0 && scrolled > opts.stop) {
            scrolled = opts.stop;
        } else {
            scrolled -= opts.start;
        }

        // Update target        
        $target.css(opts.offset, -(scrolled * opts.speed) + 'px').css(opts.css);
    };

    // Plugin defaults
    $.fn.parallax.defaults = {
        speed: 0.5,     // Relative scrolling speed, 1 == number of pixels scrolled.
        start: 0,       // Set start value in pixels
        stop: 0,   // Set stop value in pixels, 0 == infinte.
        offset: 'top',  // Sets direction, can be used for horizontal movement.
        css: {
            'position': 'relative'
        }
    };

}(jQuery));
