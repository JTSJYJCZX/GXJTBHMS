$(function () {
    var handler = $.connection.strainDatasHandler;
    handler.client.fetch = function (data) {
        $("#showtime").html(htmlEncode(data));
    };
    $.connection.hub.start().done(function () {
        handler.server.bubbling();
    });
});