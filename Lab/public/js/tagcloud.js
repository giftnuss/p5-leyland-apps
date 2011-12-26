if ( typeof Widget == "undefined" )
    Widget = {};

Widget.TagCloud = function(param){
    this.init(param);
    return this;
}

Widget.TagCloud.VERSION = '0.02'
Widget.TagCloud.EXPORT = []
Widget.TagCloud.EXPORT_OK = []
Widget.TagCloud.EXPORT_TAGS = {}

Widget.TagCloud.show = function(data, param) {
    var tc = new Widget.TagCloud()
    tc.data(data)
    tc.create()
    return tc.show(param)
}

Widget.TagCloud.prototype = (function(){return {
    init: function(param) {
        this.state = { inited: 1 }
        this._data = new Array();
    },
    create: function() {
        var d = this._data.sort(function(a, b) {return a.count - b.count})
        var max = d[d.length-1].count
        var factor = 36/Math.log(max)

        this.data(this._data.sort(function(a, b) {
            var ta = a.tag.toLowerCase()
            var tb = b.tag.toLowerCase()
            return ((ta > tb) ? 1 : (ta < tb) ? -1 : 0 )}))

        this.div = (function(data){
            var d = document.createElement("div")
            d.setAttribute("class", "jsan-widget-tagcloud")
            for (var i = 0; i < data.length ; i++) {
                var a = document.createElement("a")
                a.setAttribute("href", data[i].url)
                a.appendChild(document.createTextNode(data[i].tag))
                var s = document.createElement("span")
                var level = Math.floor(Math.log(data[i].count) * factor);
                s.setAttribute("class", "jsan-widget-tagcloud" + level)
                s.appendChild(a)
                d.appendChild(s)
                d.appendChild(document.createTextNode(" "))
            }
            return d
        })(this._data)

        this.style = (function(css){
            var s = document.createElement("style")
            s.setAttribute("type", "text/css")
            s.appendChild(document.createTextNode(css))
            return s
        })(this.css())
 
        this.state.created = 1
        return this
    },
    show: function(param) {
        if (!param)
            param = {}
        if (!param.parentNode)
           param.parentNode = document.body
        
        param.parentNode.appendChild(this.div)
        var head = ( document.getElementsByTagName("head") )[0]
        head.appendChild(this.style)
        this.state.shown = 1
    },
    hide: function() {
        if ( this.state.shown ) {
            document.body.removeChild(this.div)
            var head = ( document.getElementsByTagName("head") )[0]
            head.removeChild(this.style)
        }
    },
    add: function(tag, url, count) {
        this._data.push({tag: tag, url: url, count: count })
    },
    css: function() {
        var L = ".jsan-widget-tagcloud {line-height:1em;text-align:center;}\n.jsan-widget-tagcloud a {text-decoration: none;}\nYIELD\n"
        var T = ".jsan-widget-tagcloudLEVEL {font-size: SIZEpx;}\n"

        var rule = '';
        for(var i = 0; i < this._data.length; i++) {
            rule += T.replace(/LEVEL/, i).replace(/SIZE/, i + 12)
        }
        
        return L.replace(/YIELD/, rule)
    },
    data: function(data) {
        if ( data ) {
            this._data = data
        }
        return this._data
    }
}})()


/**

*/
