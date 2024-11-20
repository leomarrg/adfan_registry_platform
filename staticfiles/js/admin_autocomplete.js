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

document.addEventListener('DOMContentLoaded', function () {
    const searchInput = document.querySelector("#changelist-search input[name='q']");

    // Restore search input value and cursor position from localStorage
    if (searchInput) {
        const savedValue = localStorage.getItem('searchValue');
        const savedPosition = localStorage.getItem('cursorPosition');
        
        if (savedValue) {
            searchInput.value = savedValue;
        }
        if (savedPosition) {
            searchInput.setSelectionRange(savedPosition, savedPosition);
        }

        // Save value and cursor position on keyup
        searchInput.addEventListener('keyup', function () {
            localStorage.setItem('searchValue', searchInput.value);
            localStorage.setItem('cursorPosition', searchInput.selectionStart);
        });

        // Clear storage on form submission to reset when the search changes
        searchInput.closest("form").addEventListener('submit', function () {
            localStorage.removeItem('searchValue');
            localStorage.removeItem('cursorPosition');
        });
    }
});