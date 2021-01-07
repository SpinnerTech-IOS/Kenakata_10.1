//
//  Routes.swift
//  Kenakata
//
//  Created by Yasin Shamrat on 29/12/20.
//  Copyright © 2020 Md Sifat. All rights reserved.
//

import Foundation

func getProductsWithPagination(per_page: Int,page: Int) -> String {
    var url = SingleTonManager.BASE_URL + "wp-json/wc/v2/products?" + SingleTonManager.Api_User + "&" + SingleTonManager.Api_Key
    return  url + "&perpage=" + String(per_page) + "&page=" + String(page)
}
