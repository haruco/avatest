/**
 * A generic model that our Master-Detail pages list, create, and delete.
 *
 * Change "Item" to the noun your app will use. For example, a "Contact," or a
 * "Customer," or an "Animal," or something like that.
 *
 * The Items service manages creating instances of Item, so go ahead and rename
 * that something that fits your app as well.
 */
export class Item {
 coin : string; 
 code: string;
 pricePerUnit: number;
 totalUnits: number;
 totalAmount: number;
 info: Array<ItemInfo>;
 infoItem: ItemInfo;


  constructor(
    coin: string, 
    code: string,
    pricePerUnit: number,
    totalUnits: number,
    totalAmount: number,
    info: Array<ItemInfo>) {

    this.coin = coin;
    this.code = code;
    this.pricePerUnit = pricePerUnit;
    this.totalUnits = totalUnits;
    this.totalAmount = totalAmount;
    
    info.forEach(element => {
      this.infoItem.title = element.title;
      this.infoItem.desc = element.desc;
      this.info.push(this.infoItem);
    });
  }

}

export interface Item {
  coin: string;
  code: string;
  pricePerUnit: number;
  totalUnits: number;
  totalAmount: number;
  info: Array<ItemInfo>;
}

export interface ItemInfo {
  title: string;
  desc: string;
  expanded: boolean;
}
  