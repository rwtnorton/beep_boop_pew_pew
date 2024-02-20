function formatManufacturer(m) {
    let s = m['company'];
    if (m['region']) {
        s += ` (${m['region']})`;
    }
    return s;
}

function formatPublishers(game) {
    let manufacturers = game['manufacturers'] || [];
    let pubs = [];
    manufacturers.forEach(function(m) {
        pubs.push(formatManufacturer(m));
    });
    return pubs.join(' / ');
}
