function initPaginator(nav, totalPages, currentPage) {
    $(nav).jqPaginator({
        totalPages: totalPages,
        visiblePages: 10,
        currentPage: currentPage,
        first: '<li class="first"><a href="javascript:void(0);">首页</a></li>',
        prev: '<li class="prev"><a href="javascript:void(0);">上一页</a></li>',
        next: '<li class="next"><a href="javascript:void(0);">下一页</a></li>',
        last: '<li class="last"><a  href="javascript:void(0);">末页</a></li>',
        total: '<li class="total"><span>共{{totalPages}}页</span></li>',
        page: '<li class="page"><a href="javascript:void(0);">{{page}}</a></li>',
        onPageChange: function (n) {
            accessResource(n);
        }
    });
}

function jqPaginatorSetting(nav, totalPages, currentPage) {
    $(nav).css("display", "block");
    $(nav).jqPaginator('option', {
        totalPages: totalPages,
        currentPage: currentPage
    });
}



