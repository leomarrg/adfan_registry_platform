document.addEventListener('DOMContentLoaded', function () {
    const searchInput = document.querySelector("#changelist-search input[name='q']");
    const resultsContainer = document.createElement('div');
    resultsContainer.id = "autocomplete-results";
    resultsContainer.style.position = "absolute";
    resultsContainer.style.border = "1px solid #ddd";
    resultsContainer.style.backgroundColor = "#fff";
    searchInput.parentNode.appendChild(resultsContainer);

    searchInput.addEventListener('input', function () {
        const query = searchInput.value;

        if (query.length > 1) {
            fetch(`/admin/registry_app/attendee_autocomplete/?term=${query}`)
                .then(response => response.json())
                .then(data => {
                    resultsContainer.innerHTML = "";
                    data.forEach(attendee => {
                        const item = document.createElement('div');
                        item.textContent = attendee.name;  // Display only name
                        item.style.padding = "5px";
                        item.style.cursor = "pointer";

                        item.addEventListener('click', () => {
                            searchInput.value = attendee.name;
                            resultsContainer.innerHTML = "";
                        });

                        resultsContainer.appendChild(item);
                    });

                    resultsContainer.style.display = "block";
                });
        } else {
            resultsContainer.innerHTML = "";
            resultsContainer.style.display = "none";
        }
    });

    document.addEventListener('click', function (e) {
        if (!resultsContainer.contains(e.target) && e.target !== searchInput) {
            resultsContainer.style.display = "none";
        }
    });
});
