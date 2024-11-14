document.addEventListener("DOMContentLoaded", function() {
    const arrivedCheckboxes = document.querySelectorAll("input[name$='-arrived']");

    arrivedCheckboxes.forEach((checkbox) => {
        checkbox.addEventListener("change", function() {
            if (checkbox.checked) {
                const form = checkbox.closest("form");
                
                // Automatically submit form when 'arrived' is checked
                form.submit();  
            }
        });
    });
});
