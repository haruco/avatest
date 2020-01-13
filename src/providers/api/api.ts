import { HttpClient, HttpParams } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Item } from '../../models/item';
import { map } from 'rxjs/operators';
import { of } from 'rxjs';

/**
 * Api is a generic REST Api handler. Set your API url first.
 */
@Injectable()
export class Api {
  url: string = 'assets/data';
  item: Item;

  constructor(public http: HttpClient) {
  }

  getItem(): any {
    if (this.item) {
      return of(this.item);
    } else {
      return this.http
        .get('assets/data/item.json')
        .pipe(map(this.getData, this));
    }
  }

  getData(data: any) {
    this.item = data;
    return this.item;
  }
}
