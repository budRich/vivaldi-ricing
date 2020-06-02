var appendChild = Element.prototype.appendChild;
Element.prototype.appendChild = function () {
    if (arguments[0].tagName === 'DIV') {
        setTimeout(function() {
            const statusBar = document.querySelector('.toolbar-statusbar');
            const extensions = document.querySelector('.toolbar-extensions');
            const insidebtn = document.querySelector('.UrlBar-UrlFieldWrapper').nextSibling;
            const profbtn = document.querySelector('.button-circularimage');
            const check = document.querySelector('.toolbar-statusbar .toolbar-extensions');
            if ((this.classList.contains('toolbar-extensions') && statusBar && !check) || this.classList.contains('toolbar-statusbar') && extensions && !check) {
                statusBar.appendChild(insidebtn);
                statusBar.appendChild(extensions);
                statusBar.appendChild(profbtn);
            }
            else if ((this.classList.contains('toolbar-extensions') && !statusBar) || this.classList.contains('toolbar-statusbar') && !extensions) {
                console.log('this is awkward');
            }
        }.bind(this, arguments[0]));
    }
    return appendChild.apply(this, arguments);
};

var removeChild = Element.prototype.removeChild;
Element.prototype.removeChild = function () {
    if (arguments[0].tagName === 'DIV' && arguments[0].classList.contains('toolbar-extensions')) {
        console.log('let me handle it');
    }
    else {
        return removeChild.apply(this, arguments);
    }
};
