
/**
 * LeylandX-Starter Javascript
 */
var blix = {
    // borrowed from jQuery form plugin
    log: function() {
        var a = [];
        for(var i = 0; i < arguments.length; i++) {
            if(typeof {} === typeof arguments[i]) {
                a.push("OBJECT: " + JSON.stringify(arguments[i]));
            }
            else {
                a.push(arguments[i]);
            }
        }
        var msg = '[blix.log] ' + Array.prototype.join.call(a,'');
        if (window.console && window.console.log) {
            window.console.log(msg);
        }
        else if (window.opera && window.opera.postError) {
            window.opera.postError(msg);
        }
    },
    clean_errors: function () {
        $(".error_message").remove();
    },
    display_errors: function (errors) {
        for(var frm in errors) {
            var flds = errors[frm];
            for(var field in flds) {
                var errs = flds[field];
                blix.display_field_error(frm,field,errs); 
            } 
        }
    },
    display_field_error: function (formid,fieldname,errs) {
        var msg = '';
        for(var i = 0; i < errs.length; ++i) {
            msg += '<span class="error_message">' + errs[i] + '</span>';
        }
        $('*[name="' + formid + '.' + fieldname +'"]').parent().append(msg);
    }
}; 
/**
 * tiny plugin for manipulating form fields
 */
(function ($) {
    $.fn.blank = function (options) {

    }
})(jQuery);
 
jQuery(function () {

    var on_success = function (data,status,xhr) {
            blix.clean_errors();
            
            var errors;
            if(errors = data[1]) {
                blix.log(data);
                blix.display_errors(errors);
            }
    };

    var jsonize = function () {
        var result = {};
        $('form').each(function () {
            var formdata = {};
            result[this.id] = formdata;
            $(':input:not(:checkbox)',this).each(function () {
                formdata[this.name] = $(this).val();
            });
	    $(':checkbox:checked',this).each(function () {
                formdata[this.name] = $(this).val();
            });
        });
        return JSON.stringify(result);
    };

    $("#save-button").click(function (evt) {
        blix.log(jsonize());
        $.ajax({
            url: '/save',
            data: jsonize(),
            success: on_success,
            contentType: 'application/json',
            processData: false,
            type: 'POST'
        });
    });
    $("#start-button").click(function (evt) {
        $.post('/start',jsonize(),on_success);
    });

});
