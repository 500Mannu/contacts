$(document).ready(function () {
    $('.delete-action').on('click', function (e) {
        e.preventDefault();

        var itemUrl = $(this).attr('data-url');

        $('#delete-item').attr('href', itemUrl);
    })

    $('#search').on('keyup', function () {
        var q = $(this).val();
        search_table(q);
    })
})

function search_table(q) {
    $("#contacts tr:gt(0)").each(function () {
        var found = "false";

        console.log($(this).val());

        $(this).each(function () {

            if ($(this).text().toLowerCase().indexOf(q.toLowerCase()) >= 0) {
                found = "true";
            }
        });

        if (found == "true") {
            $(this).show();
        }
        else {
            $(this).hide();
        }
    })
}