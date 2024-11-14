$(document).ready(function () {
    $("#searchbar").autocomplete({
        source: function (request, response) {
            $.ajax({
                url: "/admin/registry_app/attendee_autocomplete/",
                dataType: "json",
                data: {
                    term: request.term
                },
                success: function (data) {
                    response(data);
                }
            });
        },
        minLength: 2,  // Minimum number of characters before the suggestions start showing
    });
});
