var appendChild = Element.prototype.appendChild;
Element.prototype.appendChild = function () {
    if (arguments[0].tagName === 'DIV') {
        setTimeout(function() {
            const addressBar = document.querySelector('.toolbar-addressbar');
            const statusBar = document.querySelector('.toolbar-statusbar');
            const check = document.querySelector('.toolbar-addressbar .toolbar-statusbar');
            if ((this.classList.contains('.toolbar-statusbar') && addressBar && !check) || this.classList.contains('toolbar-addressbar') && statusBar && !check) {
                addressBar.insertBefore(statusBar, addressBar.firstChild);
            }
            else if ((this.classList.contains('.toolbar-statusbar') && !addressBar) || this.classList.contains('toolbar-addressbar') && !statusBar) {
                console.log('this is awkward');
            }
        }.bind(this, arguments[0]));
    }
    return appendChild.apply(this, arguments);
};

var removeChild = Element.prototype.removeChild;
Element.prototype.removeChild = function () {
    if (arguments[0].tagName === 'DIV' && arguments[0].classList.contains('statusBar')) {
        console.log('let me handle it');
    }
    else {
        return removeChild.apply(this, arguments);
    }
};
