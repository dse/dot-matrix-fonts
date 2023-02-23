'use strict';
/*global document, setTimeout, window */

function startClock() {
    var backings = Array.from(document.querySelectorAll('[data-lcd-backing]'));
    backings.forEach(function (backing) {
        backing.innerHTML = "\u2588\u200b".repeat(10000);
    });
    tick();
}
function updateTime() {
    var clocks = Array.from(document.querySelectorAll('[data-clock]'));
    var now = new Date();
    var dow = ['Sun','Mon','Tue','Wed','Thu','Fri','Sat'][now.getDay()];
    var mm   = String(now.getMonth() + 1).padStart(2, '0');
    var dd   = String(now.getDate()).padStart(2, '0');
    var yyyy = String(now.getFullYear()).padStart(4, '0');
    var HH   = String(now.getHours()).padStart(2, '0');
    var MM   = String(now.getMinutes()).padStart(2, '0');
    var SS   = String(now.getSeconds()).padStart(2, '0');
    var ms = now.getTime() % 1000;
    var colon = (ms >= 250 && ms < 750) ? ' ' : ':';
    clocks.forEach(function (clock) {
        clock.innerHTML = dow + ' ' + mm + '/' + dd + '/' + yyyy + ' ' + HH + colon + MM + colon + SS;
    });
}
function tick() {
    updateTime();
    setTimeout(tick, 500 - Date.now() % 500);
}

if (document.readyState === 'complete') {
    startClock();
} else {
    window.addEventListener('load', startClock);
}
