"use strict";
// module Web.Cookies

// https://learn.javascript.ru/cookie
exports.setCookie =
    function(name) {
        return function(value) {
            return function(options) {
                return function() {
                    options = options || {};

                    var expires = options.expires;

                    if (typeof expires == "number" && expires) {
                        var d = new Date();
                        d.setTime(d.getTime() + expires * 1000);
                        expires = options.expires = d;
                    }
                    if (expires && expires.toUTCString) {
                        options.expires = expires.toUTCString();
                    }

                    value = encodeURIComponent(value);

                    var updatedCookie = name + "=" + value;

                    for (var propName in options) {
                        updatedCookie += "; " + propName;
                        var propValue = options[propName];
                        if (propValue !== true) {
                            updatedCookie += "=" + propValue;
                        }
                    }

                    document.cookie = updatedCookie;
                };
            };
        };
    }

// возвращает cookie с именем name, если есть, если нет, то undefined
exports.getCookie =
    function(name) {
        return function() {
            var matches = document.cookie.match(new RegExp(
                "(?:^|; )" + name.replace(/([\.$?*|{}\(\)\[\]\\\/\+^])/g, '\\$1') + "=([^;]*)"
            ));
            return matches ? decodeURIComponent(matches[1]) : undefined;
        };
    }

// удаляем вызовом setCookie с датой в прошлом
exports.deleteCookie = function(name) {
    return function() {
        setCookie(name, "", {
            expires: -1
        })
    };
}
