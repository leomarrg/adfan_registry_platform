document.addEventListener('DOMContentLoaded', function () {
    // Find the Django admin search bar
    const searchInput = document.querySelector("#changelist-search input[name='q']");

    if (searchInput) {
        // Attach a keyup event listener to the search input
        searchInput.addEventListener("keyup", function () {
            const query = searchInput.value;

            // Check if the input has more than 2 characters
            if (query.length > 2) {
                // Submit the form dynamically
                const form = searchInput.closest("form");
                form.submit();
            }
        });
    }
});
