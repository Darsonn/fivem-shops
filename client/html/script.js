let itemList = null;

AddEventHandler('onClientMapStart', function() {
    itemList = GetRootElementById('content');
    fetchItems();
});

function createListItem(item) {
    const li = document.createElement('li');
    li.innerHTML = `
        <p>${item.label}</p>
        <p>$${item.price}</p>
        <button onclick="buyItem('${item.name}', ${item.price})">Kup</button>
    `;

    return li;
}

function populateItemList(items) {
    itemList.innerHTML = '';
    items.forEach(item => {
        const li = createListItem(item);
        itemList.appendChild(li);
    });
}

function buyItem(itemName, price) {
    const data = {
        itemName: itemName,
        price: price
    };

    fetch('http://shops/buy_item', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(data)
    })
    .then(response => response.json())
    .then(response => {
        if (response === 'ok') {
            alert('Zakupiono przedmiot!');
        } else {
            alert('Nie udało się zakupić przedmiotu.');
        }
    })
    .catch(error => {
        console.error('Błąd podczas zakupu:', error);
    });
}

function fetchItems() {
    fetch('http://shops/get_items')
        .then(response => response.json())
        .then(items => {
            populateItemList(items);
        })
        .catch(error => {
            console.error('Błąd podczas pobierania przedmiotów:', error);
        });
};

function closeUI() {
    fetch('http://shops/close_ui')
        .then(response => response.json())
        .catch(error => {
            console.error('Błąd podczas zamykania UI sklepu: ', error);
        });
}