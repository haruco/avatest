import { Component, ChangeDetectorRef } from '@angular/core';
import { NavParams } from '@ionic/angular';
import { Item } from '../../models/item';
import { Api } from '../../providers';
import { Platform } from '@ionic/angular';
import { ThrowStmt } from '@angular/compiler';

declare var cordova: any;
declare var ModalWebView: any;

@Component({
  selector: 'app-home',
  templateUrl: 'home.page.html',
  styleUrls: ['home.page.scss'],
})
export class HomePage {
  public item: Item;

  constructor(public api: Api, private platform: Platform, private changeRef: ChangeDetectorRef) {
    this.getData();
    let self = this;

    this.platform.ready().then(() =>{
      var price = this.item.pricePerUnit;
      
      var modal = new ModalWebView(function (msg) {
        let returnValues = msg.split(",");
        self.item.totalUnits = parseInt(returnValues[0]);
        self.item.totalAmount = parseInt(returnValues[1]);
        self.changeRef.detectChanges();
      });
      var button = document.getElementById('btnBuy');
      button.addEventListener('click', function() {
        modal.open(price);
      });
    });
  }


  getData(){
    this.item = this.api.getItem().subscribe((data)=>{
      this.item = data;
      this.item.info.forEach(element => {
        if(element.title == "About"){
            element.expanded = true;
        }
      });
    });
  }

  expandItem(item): void {
    if (item.expanded) {
      item.expanded = false;
    } else {
      this.item.info.map(listItem => {
        if (item == listItem) {
          listItem.expanded = !listItem.expanded;
        } else {
          listItem.expanded = false;
        }
        return listItem;
      });
    }
  }
}