let currentOpen = null; // Track the currently open file content

function toggleFileContent(fileId) {
    // Get the file content div and arrow icon by ID
    const fileContent = document.getElementById('file-content-' + fileId);
    const arrowIcon = document.getElementById('arrow-icon-' + fileId);

    // Close the currently open file content if it’s different from the clicked one
    if (currentOpen && currentOpen !== fileId) {
        const currentFileContent = document.getElementById('file-content-' + currentOpen);
        const currentArrowIcon = document.getElementById('arrow-icon-' + currentOpen);
        if (currentFileContent && currentArrowIcon) {
            currentFileContent.style.maxHeight = '0';
            currentFileContent.style.opacity = '0';
            currentArrowIcon.classList.remove('rotate');
        }
        currentOpen = null;
    }

    // Toggle the clicked file content
    if (!fileContent.classList.contains('open')) {
        fileContent.classList.add('open');
        fileContent.style.maxHeight = '200px'; // Desired height to expand
        fileContent.style.opacity = '1';
        arrowIcon.classList.add('rotate');
        currentOpen = fileId; // Update the currently open content ID
    } else {
        fileContent.classList.remove('open');
        fileContent.style.maxHeight = '0';
        fileContent.style.opacity = '0';
        arrowIcon.classList.remove('rotate');
        currentOpen = null; // No content is open
    }
}

// Ensure all file content is hidden on page load
window.addEventListener('DOMContentLoaded', (event) => {
    document.querySelectorAll('.file-content').forEach((element) => {
        element.style.maxHeight = '0'; // Start closed
        element.style.opacity = '0'; // Start hidden
        element.style.transition = 'max-height 0.5s ease, opacity 0.5s ease'; // Smooth transition
    });
});
