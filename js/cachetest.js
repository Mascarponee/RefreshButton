var cachetest = (function () {
    var testResults = {}; //plain test results
    var formattedResults = {}; //test results with highlighted changes
    var readyToRender = false;
    var oldData = parseCookies()['cachetest'] || {};

    function renderResult(resourceName, data) {
        var o = oldData[resourceName] || {};
        $("#resultsTemplate").tmpl({ name: resourceName, data: data, oldData: o }).appendTo("#testResults");
    }

    function parseCookies() {
        var cookies = {}, i, pair, name, value, separated = document.cookie.split(';'), unparsedValue;
        for (i = 0; i < separated.length; i++) {
            pair = separated[i].split('=');
            name = pair[0].replace(/^\s*/, '').replace(/\s*$/, '');

            try {
                value = decodeURIComponent(pair[1]);
            }
            catch (e1) {
                value = pair[1];
            }

            if (typeof JSON === 'object' && JSON !== null && typeof JSON.parse === 'function') {
                try {
                    unparsedValue = value;
                    value = JSON.parse(value);
                }
                catch (e2) {
                    value = unparsedValue;
                }
            }

            cookies[name] = value;
        }
        return cookies;
    };

    function updateCookies() {
        var value = '';
        if (typeof JSON === 'object' && JSON !== null && typeof JSON.stringify === 'function') {
            value = JSON.stringify(testResults);
        }
        document.cookie = 'cachetest=' + encodeURIComponent(value);
    }

    $(document).ready(function () {
        readyToRender = true;
        for (var resourceName in testResults) {
            renderResult(resourceName, testResults[resourceName]);
        }
    });

    return {
        scriptLoadedCallback: function (resourceName, data) {
            //if (!testResults[resourceName]) {           
            delete data['Cookie'];
            testResults[resourceName] = data;
            updateCookies();
            //}
            if (readyToRender) {
                renderResult(resourceName, data);
            }
        }

    }

})();

function onButtonClick() {
    aler('here');
}