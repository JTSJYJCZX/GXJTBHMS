function htmlEncode(value) {
    var encodeValue = $('<div/>').text(value).html();
    return encodeValue;
}