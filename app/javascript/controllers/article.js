const handleToggleRead = (event, articleId) => {
  let csrfToken = document.querySelector('meta[name="csrf-token"]').content;

  let xhr = new XMLHttpRequest();
  xhr.open('PATCH', '/articles/' + articleId);
  xhr.setRequestHeader('X-CSRF-Token', csrfToken);

  xhr.onreadystatechange = () => {
    if (xhr.status === 200) {
      const label = event.target.nextElementSibling;
      label.textContent = event.target.checked ? 'Mark Unread' : 'Mark Read';
    } else {
      console.error('Error:', xhr.status);
    }
  };

  xhr.send();
};
