import { SETTING } from '@shell/config/settings';
import { MANAGEMENT } from '@shell/config/types';

let favIconSet = false;

export function haveSetFavIcon() {
  return favIconSet;
}

export function setFavIcon(store) {
  const res = store.getters['management/byId'](MANAGEMENT.SETTING, SETTING.FAVICON);
  const brandSetting = store.getters['management/byId'](MANAGEMENT.SETTING, SETTING.BRAND);
  const link = findIconLink(document.head.getElementsByTagName('link'));

  if (link) {
    let brandImage;

    if (brandSetting?.value === 'suse') {
      brandImage = require('~shell/assets/brand/suse/favicon.png');
    } else if (brandSetting?.value === 'csp') {
      brandImage = require('~shell/assets/brand/csp/favicon.png');
    }

    link.href = "data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMjQiIGhlaWdodD0iMjUiIHZpZXdCb3g9IjAgMCAyNCAyNSIgZmlsbD0ibm9uZSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KPHBhdGggZmlsbC1ydWxlPSJldmVub2RkIiBjbGlwLXJ1bGU9ImV2ZW5vZGQiIGQ9Ik0wIDAuMzUxMjU3VjkuNDU2NEgzLjMyMjM1QzE2LjU4OCA5LjQ1NjQgNy40MjU4IDI0LjM1NTYgMjAuNjc2NyAyNC4zNTU2SDI0VjE1LjI1MTRIMjAuNjc2N0M3LjQxODQ5IDE1LjI1MTQgMTYuNTg4IDAuMzUxMjU3IDMuMzIyMzUgMC4zNTEyNTdIMFoiIGZpbGw9IiMwQ0UyRjIiLz4KPC9zdmc+Cg==";
    favIconSet = true;
  }
}

function getCurrentFavIcon() {
  const link = findIconLink(document.head.getElementsByTagName('link'));

  return link ? link.href : '';
}

function findIconLink(links) {
  for (let i = 0; i < links.length; i++) {
    const link = links[i];

    if (link.rel?.includes('icon')) {
      return link;
    }
  }

  return undefined;
}

const defaultFavIcon = getCurrentFavIcon();
