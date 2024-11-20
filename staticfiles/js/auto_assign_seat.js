document.addEventListener("DOMContentLoaded", function() {
    const arrivedCheckboxes = document.querySelectorAll("input[name='arrived']");

    arrivedCheckboxes.forEach((checkbox) => {
        checkbox.addEventListener("change", function() {
            if (checkbox.checked) {
                const attendeeId = checkbox.closest('tr').getAttribute('data-object-id');
                if (attendeeId) {
                    fetch('/admin/registry_app/attendee/mark-arrived/', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/json',
                            'X-CSRFToken': getCookie('csrftoken'),  // CSRF token handling
                        },
                        body: JSON.stringify({ id: attendeeId })
                    }).then(response => response.json())
                      .then(data => {
                          if (!data.success) {
                              alert('Error: ' + data.error);
                          }
                      }).catch(error => {
                          alert('Error: ' + error);
                      });
                }
            }
        });
    });

    // Function to get the CSRF token
    function getCookie(name) {
        let cookieValue = null;
        if (document.cookie && document.cookie !== '') {
            const cookies = document.cookie.split(';');
            for (let i = 0; i < cookies.length; i++) {
                const cookie = cookies[i].trim();
                if (cookie.substring(0, name.length + 1) === (name + '=')) {
                    cookieValue = decodeURIComponent(cookie.substring(name.length + 1));
                    break;
                }
            }
        }
        return cookieValue;
    }
});
