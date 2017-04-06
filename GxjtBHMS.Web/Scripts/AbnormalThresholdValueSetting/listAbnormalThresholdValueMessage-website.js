
function abnormalSaveThresholdValue(saveSender, url) {
    if (!confirm('是否操作?')) return;
    var $saveSender = $(saveSender);
    var typeId = $saveSender.prev().val();
    var $textboxArray = findAbnormalThresholdValuesFromTheSameLineTextBoxs($saveSender);//查询阈值所在的文本框
    var headers = getHeadersWithAntiForgeryToken();
    var params = {
        TypeId: typeId,
          };         
    var abnormalThresholdValues = [];
        $textboxArray.each(function (i) {
            abnormalThresholdValues.push($(this).val());
        });
        params['AbnormalThresholdValues'] = abnormalThresholdValues;  
       ajaxHandler(url, headers, params);
}

function findAbnormalThresholdValuesFromTheSameLineTextBoxs(button) {
    return button.parent().parent().find(":text");
}
