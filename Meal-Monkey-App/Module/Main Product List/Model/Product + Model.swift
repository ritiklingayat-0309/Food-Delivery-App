//
//  Product + Model.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 10/08/25.
//

import Foundation

class ProductModel : Codable {
    var intId: Int = 0
    var strProductName: String = ""
    var strProductDescription: String = ""
    var floatProductRating: Float = 0.0
    var doubleProductPrice: Double = 0.0
    var strProductImage: String = ""
    var intProductQty: Int?
    var intTotalNumberOfRatings: Int = 0
    var objProductCategory: ProductCategory = .Gujarati
    var objProductType: ProductType = .food
    init(
        intId: Int,
        strProductName: String,
        strProductDescription: String,
        floatProductRating: Float,
        doubleProductPrice: Double,
        strProductImage: String,
        intProductQty: Int? = nil,
        intTotalNumberOfRatings: Int,
        objProductCategory: ProductCategory,
        objProductType: ProductType
    ) {
        self.intId = intId
        self.strProductName = strProductName
        self.strProductDescription = strProductDescription
        self.floatProductRating = floatProductRating
        self.doubleProductPrice = doubleProductPrice
        self.strProductImage = strProductImage
        self.intProductQty = intProductQty
        self.intTotalNumberOfRatings = intTotalNumberOfRatings
        self.objProductCategory = objProductCategory
        self.objProductType = objProductType
    }
//    class func addProductData() -> [ProductModel] {
//        return [
//            ProductModel(
//                intId: 1,
//                strProductName: "Masala Dosa",
//                strProductDescription:
//                    "A crispy, golden crepe made from fermented rice and lentil batter, filled with a spiced potato mash and served with sambar and coconut chutney.",
//                floatProductRating: 4.8,
//                doubleProductPrice: 120,
//                strProductImage: "ic_masaladosa",
//                intTotalNumberOfRatings: 350,
//                objProductCategory: .SouthIndian,
//                objProductType: .food
//            ),
//            ProductModel(
//                intId: 2,
//                strProductName: "Idli Sambar",
//                strProductDescription:
//                    "Soft and fluffy steamed rice cakes served with a hearty lentil and vegetable stew, seasoned with aromatic spices.",
//                floatProductRating: 4.5,
//                doubleProductPrice: 90,
//                strProductImage: "ic_idlisambar",
//                intTotalNumberOfRatings: 280,
//                objProductCategory: .SouthIndian,
//                objProductType: .food
//            ),
//            ProductModel(
//                intId: 3,
//                strProductName: "Vada",
//                strProductDescription:
//                    "A savory, deep-fried fritter made from lentil batter, crispy on the outside and soft on the inside, best enjoyed with sambar or chutney.",
//                floatProductRating: 4.4,
//                doubleProductPrice: 70,
//                strProductImage: "ic_vada",
//                intTotalNumberOfRatings: 210,
//                objProductCategory: .SouthIndian,
//                objProductType: .food
//            ),
//            ProductModel(
//                intId: 4,
//                strProductName: "Uttapam",
//                strProductDescription:
//                    "A thick, savory pancake made from fermented rice batter, topped with finely chopped vegetables like onions, tomatoes, and chillies.",
//                floatProductRating: 4.6,
//                doubleProductPrice: 110,
//                strProductImage: "ic_uttapam",
//                intTotalNumberOfRatings: 240,
//                objProductCategory: .SouthIndian,
//                objProductType: .food
//            ),
//            ProductModel(
//                intId: 5,
//                strProductName: "Rava Upma",
//                strProductDescription:
//                    "A delicious and healthy breakfast dish made from roasted semolina and a mix of vegetables, seasoned with mustard seeds and curry leaves.",
//                floatProductRating: 4.3,
//                doubleProductPrice: 85,
//                strProductImage: "ic_ravaupma",
//                intTotalNumberOfRatings: 180,
//                objProductCategory: .SouthIndian,
//                objProductType: .food
//            ),
//            ProductModel(
//                intId: 6,
//                strProductName: "Payasam",
//                strProductDescription:
//                    "A traditional creamy and sweet pudding made from rice, milk, jaggery, and flavored with cardamom and nuts, perfect for any celebration.",
//                floatProductRating: 4.7,
//                doubleProductPrice: 100,
//                strProductImage: "ic_payasam",
//                intTotalNumberOfRatings: 150,
//                objProductCategory: .SouthIndian,
//                objProductType: .Desserts
//            ),
//            ProductModel(
//                intId: 7,
//                strProductName: "Kesari Bath",
//                strProductDescription:
//                    "A rich, sweet dish made from semolina, ghee, sugar, and saffron, garnished with cashews and raisins for a delightful treat.",
//                floatProductRating: 4.5,
//                doubleProductPrice: 80,
//                strProductImage: "ic_kesaribath",
//                intTotalNumberOfRatings: 130,
//                objProductCategory: .SouthIndian,
//                objProductType: .Desserts
//            ),
//            ProductModel(
//                intId: 8,
//                strProductName: "Mysore Pak",
//                strProductDescription:
//                    "A classic sweet made from chickpea flour, sugar, and generous amounts of ghee, offering a dense, fudge-like texture that melts in your mouth.",
//                floatProductRating: 4.6,
//                doubleProductPrice: 150,
//                strProductImage: "ic_mysorepak",
//                intTotalNumberOfRatings: 170,
//                objProductCategory: .SouthIndian,
//                objProductType: .Desserts
//            ),
//            ProductModel(
//                intId: 9,
//                strProductName: "Coconut Burfi",
//                strProductDescription:
//                    "A simple yet delicious fudge made from grated coconut, sugar, and milk, often flavored with cardamom and decorated with edible silver leaf.",
//                floatProductRating: 4.4,
//                doubleProductPrice: 120,
//                strProductImage: "ic_coconutburfi",
//                intTotalNumberOfRatings: 110,
//                objProductCategory: .SouthIndian,
//                objProductType: .Desserts
//            ),
//            ProductModel(
//                intId: 10,
//                strProductName: "Adhirasam",
//                strProductDescription:
//                    "A traditional sweet pastry made from rice flour and jaggery, deep-fried to a golden-brown finish, with a slightly chewy and crunchy texture.",
//                floatProductRating: 4.2,
//                doubleProductPrice: 90,
//                strProductImage: "ic_adhirasam",
//                intTotalNumberOfRatings: 95,
//                objProductCategory: .SouthIndian,
//                objProductType: .Desserts
//            ),
//            ProductModel(
//                intId: 11,
//                strProductName: "Filter Coffee",
//                strProductDescription:
//                    "A strong, aromatic coffee decoction brewed with a traditional filter and mixed with frothy, hot milk, a perfect start to the day.",
//                floatProductRating: 4.9,
//                doubleProductPrice: 60,
//                strProductImage: "ic_filtercoffee",
//                intTotalNumberOfRatings: 400,
//                objProductCategory: .SouthIndian,
//                objProductType: .Beverages
//            ),
//            ProductModel(
//                intId: 12,
//                strProductName: "Madras Kapi",
//                strProductDescription:
//                    "A distinct type of South Indian coffee known for its strong, full-bodied flavor and unique brewing style, served with a perfect foam.",
//                floatProductRating: 4.8,
//                doubleProductPrice: 65,
//                strProductImage: "ic_madraskapi",
//                intTotalNumberOfRatings: 250,
//                objProductCategory: .SouthIndian,
//                objProductType: .Beverages
//            ),
//            ProductModel(
//                intId: 13,
//                strProductName: "Neer Mor",
//                strProductDescription:
//                    "A refreshing buttermilk drink seasoned with ginger, green chillies, curry leaves, and a pinch of asafoetida, perfect for a hot day.",
//                floatProductRating: 4.6,
//                doubleProductPrice: 50,
//                strProductImage: "ic_neermor",
//                intTotalNumberOfRatings: 180,
//                objProductCategory: .SouthIndian,
//                objProductType: .Beverages
//            ),
//            ProductModel(
//                intId: 14,
//                strProductName: "Jigarthanda",
//                strProductDescription:
//                    "A famous cold beverage from Madurai, made with milk, almond gum, sarsaparilla syrup, and a scoop of ice cream, offering a rich and creamy taste.",
//                floatProductRating: 4.7,
//                doubleProductPrice: 110,
//                strProductImage: "ic_jigarthanda",
//                intTotalNumberOfRatings: 220,
//                objProductCategory: .SouthIndian,
//                objProductType: .Beverages
//            ),
//            ProductModel(
//                intId: 15,
//                strProductName: "Sundaikkai Mor Kulambu",
//                strProductDescription:
//                    "A spicy and tangy buttermilk-based curry with sundakkai (turkey berry), offering a unique flavor profile and served with rice.",
//                floatProductRating: 4.4,
//                doubleProductPrice: 130,
//                strProductImage: "ic_sundaikkai_morkulambu",
//                intTotalNumberOfRatings: 100,
//                objProductCategory: .SouthIndian,
//                objProductType: .Beverages
//            ),
//            ProductModel(
//                intId: 16,
//                strProductName: "Hakka Noodles",
//                strProductDescription:
//                    "Delicious stir-fried noodles tossed with fresh vegetables, flavorful sauces, and aromatic spices, giving a perfect balance of taste and texture in every bite.",
//                floatProductRating: 4.6,
//                doubleProductPrice: 150,
//                strProductImage: "ic_hakkanoodles",
//                intTotalNumberOfRatings: 220,
//                objProductCategory: .Chinese,
//                objProductType: .food
//            ),
//            ProductModel(
//                intId: 17,
//                strProductName: "Manchurian",
//                strProductDescription:
//                    "Crispy vegetable balls cooked in a tangy and spicy Manchurian sauce, packed with bold flavors and perfect for both rice and noodles lovers.",
//                floatProductRating: 4.3,
//                doubleProductPrice: 180,
//                strProductImage: "ic_manchurian",
//                intTotalNumberOfRatings: 180,
//                objProductCategory: .Chinese,
//                objProductType: .food
//            ),
//            ProductModel(
//                intId: 18,
//                strProductName: "Spring Rolls",
//                strProductDescription:
//                    "Golden-fried rolls stuffed with a savory mix of vegetables, noodles, and seasonings, served with a sweet and spicy dipping sauce for extra flavor.",
//                floatProductRating: 4.4,
//                doubleProductPrice: 120,
//                strProductImage: "ic_springrolls",
//                intTotalNumberOfRatings: 150,
//                objProductCategory: .Chinese,
//                objProductType: .food
//            ),
//            ProductModel(
//                intId: 19,
//                strProductName: "Schezwan Fried Rice",
//                strProductDescription:
//                    "Fragrant fried rice cooked with colorful vegetables, tossed in fiery Schezwan sauce, and loaded with irresistible spicy flavors for a satisfying meal.",
//                floatProductRating: 4.5,
//                doubleProductPrice: 160,
//                strProductImage: "ic_schezwanfriedrice",
//                intTotalNumberOfRatings: 210,
//                objProductCategory: .Chinese,
//                objProductType: .food
//            ),
//            ProductModel(
//                intId: 20,
//                strProductName: "Kung Pao Tofu",
//                strProductDescription:
//                    "Soft tofu cubes stir-fried with crunchy peanuts, vegetables, and a flavorful Kung Pao sauce, creating a perfect mix of sweet, spicy, and savory flavors.",
//                floatProductRating: 4.2,
//                doubleProductPrice: 200,
//                strProductImage: "ic_kungpaotofu",
//                intTotalNumberOfRatings: 140,
//                objProductCategory: .Chinese,
//                objProductType: .food
//            ),
//            // Chinese Desserts
//            ProductModel(
//                intId: 21,
//                strProductName: "Mango Pudding",
//                strProductDescription:
//                    "Smooth and creamy pudding made from fresh mangoes, milk, and a hint of sweetness, chilled to perfection for a refreshing dessert experience.",
//                floatProductRating: 4.6,
//                doubleProductPrice: 100,
//                strProductImage: "ic_mangopudding",
//                intTotalNumberOfRatings: 95,
//                objProductCategory: .Chinese,
//                objProductType: .Desserts
//            ),
//            ProductModel(
//                intId: 22,
//                strProductName: "Sesame Balls",
//                strProductDescription:
//                    "Crispy golden sesame-coated balls with a sweet red bean paste filling, offering a delightful combination of nutty, crunchy, and soft textures.",
//                floatProductRating: 4.3,
//                doubleProductPrice: 110,
//                strProductImage: "ic_sesameballs",
//                intTotalNumberOfRatings: 105,
//                objProductCategory: .Chinese,
//                objProductType: .Desserts
//            ),
//            ProductModel(
//                intId: 23,
//                strProductName: "Egg Tart",
//                strProductDescription:
//                    "Flaky pastry shell filled with smooth, sweet egg custard, baked until golden brown and perfect for enjoying with tea or coffee.",
//                floatProductRating: 4.5,
//                doubleProductPrice: 90,
//                strProductImage: "ic_eggtart",
//                intTotalNumberOfRatings: 120,
//                objProductCategory: .Chinese,
//                objProductType: .Desserts
//            ),
//            ProductModel(
//                intId: 24,
//                strProductName: "Almond Cookies",
//                strProductDescription:
//                    "Crispy and buttery cookies with a rich almond flavor, perfect for a light snack or as a sweet companion to your tea.",
//                floatProductRating: 4.4,
//                doubleProductPrice: 85,
//                strProductImage: "ic_almondcookies",
//                intTotalNumberOfRatings: 110,
//                objProductCategory: .Chinese,
//                objProductType: .Desserts
//            ),
//            ProductModel(
//                intId: 25,
//                strProductName: "Lychee Jelly",
//                strProductDescription:
//                    "Soft and wobbly jelly infused with the tropical sweetness of fresh lychee, served chilled for a refreshing dessert treat.",
//                floatProductRating: 4.2,
//                doubleProductPrice: 95,
//                strProductImage: "ic_lycheejelly",
//                intTotalNumberOfRatings: 90,
//                objProductCategory: .Chinese,
//                objProductType: .Desserts
//            ),
//            ProductModel(
//                intId: 26,
//                strProductName: "Bubble Tea",
//                strProductDescription:
//                    "Refreshing milk tea served with chewy tapioca pearls, blending creamy, sweet, and fun textures into every delicious sip.",
//                floatProductRating: 4.7,
//                doubleProductPrice: 150,
//                strProductImage: "ic_bubbletea",
//                intTotalNumberOfRatings: 300,
//                objProductCategory: .Chinese,
//                objProductType: .Beverages
//            ),
//            ProductModel(
//                intId: 27,
//                strProductName: "Jasmine Tea",
//                strProductDescription:
//                    "A fragrant green tea infused with the delicate aroma of jasmine flowers, offering a soothing and calming tea experience.",
//                floatProductRating: 4.5,
//                doubleProductPrice: 80,
//                strProductImage: "ic_jasminetea",
//                intTotalNumberOfRatings: 200,
//                objProductCategory: .Chinese,
//                objProductType: .Beverages
//            ),
//            ProductModel(
//                intId: 28,
//                strProductName: "Soy Milk",
//                strProductDescription:
//                    "Smooth and slightly sweet beverage made from soybeans, rich in protein and perfect for a healthy drink option.",
//                floatProductRating: 4.3,
//                doubleProductPrice: 60,
//                strProductImage: "ic_soymilk",
//                intTotalNumberOfRatings: 150,
//                objProductCategory: .Chinese,
//                objProductType: .Beverages
//            ),
//            ProductModel(
//                intId: 29,
//                strProductName: "Chrysanthemum Tea",
//                strProductDescription:
//                    "A light, floral herbal tea made from dried chrysanthemum flowers, naturally caffeine-free and enjoyed hot or cold.",
//                floatProductRating: 4.4,
//                doubleProductPrice: 70,
//                strProductImage: "ic_chrysanthemumtea",
//                intTotalNumberOfRatings: 130,
//                objProductCategory: .Chinese,
//                objProductType: .Beverages
//            ),
//            ProductModel(
//                intId: 30,
//                strProductName: "Iced Lemon Tea",
//                strProductDescription:
//                    "Refreshing black tea served over ice with fresh lemon juice, offering a perfect balance of citrusy tang and sweetness.",
//                floatProductRating: 4.6,
//                doubleProductPrice: 90,
//                strProductImage: "ic_icedlemontea",
//                intTotalNumberOfRatings: 170,
//                objProductCategory: .Chinese,
//                objProductType: .Beverages
//            ),
//            ProductModel(
//                intId: 31,
//                strProductName: "Paneer Tikka Masala",
//                strProductDescription: "Very tasty Punjabi dish",
//                floatProductRating: 4.5,
//                doubleProductPrice: 200,
//                strProductImage: "ic_paneertikka",
//                intTotalNumberOfRatings: 120,
//                objProductCategory: .Punjabi,
//                objProductType: .food
//            ),
//            ProductModel(
//                intId: 32,
//                strProductName: "Chole Bhature",
//                strProductDescription: "Spicy and rich Punjabi food",
//                floatProductRating: 4.6,
//                doubleProductPrice: 150,
//                strProductImage: "ic_cholebhature",
//                intTotalNumberOfRatings: 200,
//                objProductCategory: .Punjabi,
//                objProductType: .food
//            ),
//            ProductModel(
//                intId: 33,
//                strProductName: "Butter Naan",
//                strProductDescription: "Soft naan with butter",
//                floatProductRating: 4.4,
//                doubleProductPrice: 40,
//                strProductImage: "ic_butternaan",
//                intTotalNumberOfRatings: 300,
//                objProductCategory: .Punjabi,
//                objProductType: .food
//            ),
//            ProductModel(
//                intId: 34,
//                strProductName: "Dal Makhani",
//                strProductDescription: "Slow cooked dal with butter",
//                floatProductRating: 4.7,
//                doubleProductPrice: 180,
//                strProductImage: "ic_dalmakhani",
//                intTotalNumberOfRatings: 250,
//                objProductCategory: .Punjabi,
//                objProductType: .food
//            ),
//            ProductModel(
//                intId: 35,
//                strProductName: "Aloo Paratha",
//                strProductDescription: "Stuffed paratha with butter",
//                floatProductRating: 4.5,
//                doubleProductPrice: 100,
//                strProductImage: "ic_alooparatha",
//                intTotalNumberOfRatings: 180,
//                objProductCategory: .Punjabi,
//                objProductType: .food
//            ),
//            ProductModel(
//                intId: 36,
//                strProductName: "Gulab Jamun",
//                strProductDescription: "Soft sweet balls in syrup",
//                floatProductRating: 4.8,
//                doubleProductPrice: 90,
//                strProductImage: "ic_gulabjamun",
//                intTotalNumberOfRatings: 300,
//                objProductCategory: .Punjabi,
//                objProductType: .Desserts
//            ),
//            ProductModel(
//                intId: 37,
//                strProductName: "Rasgulla",
//                strProductDescription: "Spongy sweet balls",
//                floatProductRating: 4.7,
//                doubleProductPrice: 85,
//                strProductImage: "ic_rasgulla",
//                intTotalNumberOfRatings: 250,
//                objProductCategory: .Punjabi,
//                objProductType: .Desserts
//            ),
//            ProductModel(
//                intId: 38,
//                strProductName: "Jalebi",
//                strProductDescription: "Crispy and sweet",
//                floatProductRating: 4.6,
//                doubleProductPrice: 70,
//                strProductImage: "ic_jalebi",
//                intTotalNumberOfRatings: 280,
//                objProductCategory: .Punjabi,
//                objProductType: .Desserts
//            ),
//            ProductModel(
//                intId: 39,
//                strProductName: "Kheer",
//                strProductDescription: "Sweet rice pudding",
//                floatProductRating: 4.5,
//                doubleProductPrice: 110,
//                strProductImage: "ic_kheer",
//                intTotalNumberOfRatings: 200,
//                objProductCategory: .Punjabi,
//                objProductType: .Desserts
//            ),
//            ProductModel(
//                intId: 40,
//                strProductName: "Ladoo",
//                strProductDescription: "Traditional Indian sweet",
//                floatProductRating: 4.4,
//                doubleProductPrice: 60,
//                strProductImage: "ic_ladoo",
//                intTotalNumberOfRatings: 150,
//                objProductCategory: .Punjabi,
//                objProductType: .Desserts
//            ),
//            ProductModel(
//                intId: 41,
//                strProductName: "Lassi",
//                strProductDescription: "Sweet Punjabi yogurt drink",
//                floatProductRating: 4.8,
//                doubleProductPrice: 50,
//                strProductImage: "ic_lassi",
//                intTotalNumberOfRatings: 400,
//                objProductCategory: .Punjabi,
//                objProductType: .Beverages
//            ),
//            ProductModel(
//                intId: 42,
//                strProductName: "Masala Chai",
//                strProductDescription: "Spicy Indian tea",
//                floatProductRating: 4.7,
//                doubleProductPrice: 30,
//                strProductImage: "ic_masalachai",
//                intTotalNumberOfRatings: 350,
//                objProductCategory: .Punjabi,
//                objProductType: .Beverages
//            ),
//            ProductModel(
//                intId: 43,
//                strProductName: "Badam Milk",
//                strProductDescription: "Sweet almond flavored milk",
//                floatProductRating: 4.6,
//                doubleProductPrice: 60,
//                strProductImage: "ic_badammilk",
//                intTotalNumberOfRatings: 250,
//                objProductCategory: .Punjabi,
//                objProductType: .Beverages
//            ),
//            ProductModel(
//                intId: 44,
//                strProductName: "Rose Sharbat",
//                strProductDescription: "Refreshing rose drink",
//                floatProductRating: 4.5,
//                doubleProductPrice: 40,
//                strProductImage: "ic_rosesharbat",
//                intTotalNumberOfRatings: 200,
//                objProductCategory: .Punjabi,
//                objProductType: .Beverages
//            ),
//            ProductModel(
//                intId: 45,
//                strProductName: "Cold Coffee",
//                strProductDescription: "Chilled coffee drink",
//                floatProductRating: 4.4,
//                doubleProductPrice: 80,
//                strProductImage: "ic_coldcoffee",
//                intTotalNumberOfRatings: 180,
//                objProductCategory: .Punjabi,
//                objProductType: .Beverages
//            ),
//            ProductModel(
//                intId: 46,
//                strProductName: "Undhiyu",
//                strProductDescription:
//                    "Traditional Gujarati mixed vegetable curry",
//                floatProductRating: 4.5,
//                doubleProductPrice: 150.0,
//                strProductImage: "Ic_Undhiyu",
//                intTotalNumberOfRatings: 120,
//                objProductCategory: .Gujarati,
//                objProductType: .food
//            ),
//            ProductModel(
//                intId: 47,
//                strProductName: "Khaman Dhokla",
//                strProductDescription:
//                    "Soft and fluffy steamed gram flour snack",
//                floatProductRating: 4.7,
//                doubleProductPrice: 50.0,
//                strProductImage: "Ic_Khaman_Dhokla",
//                intTotalNumberOfRatings: 200,
//                objProductCategory: .Gujarati,
//                objProductType: .food
//            ),
//            ProductModel(
//                intId: 48,
//                strProductName: "Thepla",
//                strProductDescription:
//                    "Spiced flatbread made from whole wheat flour",
//                floatProductRating: 4.4,
//                doubleProductPrice: 40.0,
//                strProductImage: "Ic_Thepla",
//                intTotalNumberOfRatings: 180,
//                objProductCategory: .Gujarati,
//                objProductType: .food
//            ),
//            ProductModel(
//                intId: 49,
//                strProductName: "Sev Tameta Nu Shaak",
//                strProductDescription:
//                    "Sweet-tangy tomato curry topped with sev",
//                floatProductRating: 4.3,
//                doubleProductPrice: 90.0,
//                strProductImage: "Ic_Sev_Tameta",
//                intTotalNumberOfRatings: 110,
//                objProductCategory: .Gujarati,
//                objProductType: .food
//            ),
//            ProductModel(
//                intId: 50,
//                strProductName: "Bajra Rotla + Ringan olo",
//                strProductDescription:
//                    "Pearl millet flatbread served with jaggery & ghee",
//                floatProductRating: 4.6,
//                doubleProductPrice: 60.0,
//                strProductImage: "ic_Bajra_Rotla_Ringan_Olo",
//                intTotalNumberOfRatings: 95,
//                objProductCategory: .Gujarati,
//                objProductType: .food
//            ),
//            ProductModel(
//                intId: 51,
//                strProductName: "Basundi",
//                strProductDescription: "Sweetened thickened milk with cardamom",
//                floatProductRating: 4.8,
//                doubleProductPrice: 120.0,
//                strProductImage: "Ic_Basundi",
//                intTotalNumberOfRatings: 130,
//                objProductCategory: .Gujarati,
//                objProductType: .Desserts
//            ),
//            ProductModel(
//                intId: 52,
//                strProductName: "Shrikhand",
//                strProductDescription:
//                    "Sweet yogurt dessert flavored with saffron",
//                floatProductRating: 4.9,
//                doubleProductPrice: 100.0,
//                strProductImage: "Ic_Shrikhand",
//                intTotalNumberOfRatings: 150,
//                objProductCategory: .Gujarati,
//                objProductType: .Desserts
//            ),
//            ProductModel(
//                intId: 53,
//                strProductName: "Mohanthal",
//                strProductDescription:
//                    "Gram flour fudge with ghee & dry fruits",
//                floatProductRating: 4.6,
//                doubleProductPrice: 140.0,
//                strProductImage: "Ic_Mohanthal",
//                intTotalNumberOfRatings: 85,
//                objProductCategory: .Gujarati,
//                objProductType: .Desserts
//            ),
//            ProductModel(
//                intId: 54,
//                strProductName: "Sutarfeni",
//                strProductDescription:
//                    "Flaky sweet made from rice flour & sugar syrup",
//                floatProductRating: 4.5,
//                doubleProductPrice: 150.0,
//                strProductImage: "Ic_SutarFeni",
//                intTotalNumberOfRatings: 75,
//                objProductCategory: .Gujarati,
//                objProductType: .Desserts
//            ),
//            ProductModel(
//                intId: 55,
//                strProductName: "Ghari",
//                strProductDescription: "Sweet made from mawa & dry fruits",
//                floatProductRating: 4.4,
//                doubleProductPrice: 160.0,
//                strProductImage: "Ic_Ghari",
//                intTotalNumberOfRatings: 60,
//                objProductCategory: .Gujarati,
//                objProductType: .Desserts
//            ),
//            ProductModel(
//                intId: 56,
//                strProductName: "Chaas",
//                strProductDescription: "Refreshing buttermilk with spices",
//                floatProductRating: 4.7,
//                doubleProductPrice: 20.0,
//                strProductImage: "Ic_Chaas",
//                intTotalNumberOfRatings: 210,
//                objProductCategory: .Gujarati,
//                objProductType: .Beverages
//            ),
//            ProductModel(
//                intId: 57,
//                strProductName: "Masala Chai",
//                strProductDescription: "Spiced Indian tea brewed with milk",
//                floatProductRating: 4.8,
//                doubleProductPrice: 25.0,
//                strProductImage: "Ic_Masala_Chai",
//                intTotalNumberOfRatings: 300,
//                objProductCategory: .Gujarati,
//                objProductType: .Beverages
//            ),
//            ProductModel(
//                intId: 58,
//                strProductName: "Kokum Sharbat",
//                strProductDescription: "Sweet-sour drink made from kokum fruit",
//                floatProductRating: 4.5,
//                doubleProductPrice: 30.0,
//                strProductImage: "Ic_Kokum_Sharbat",
//                intTotalNumberOfRatings: 90,
//                objProductCategory: .Gujarati,
//                objProductType: .Beverages
//            ),
//            ProductModel(
//                intId: 59,
//                strProductName: "Limbu Pani",
//                strProductDescription: "Fresh lemon water with sugar and salt",
//                floatProductRating: 4.6,
//                doubleProductPrice: 15.0,
//                strProductImage: "Ic_Limbu_Pani",
//                intTotalNumberOfRatings: 250,
//                objProductCategory: .Gujarati,
//                objProductType: .Beverages
//            ),
//            ProductModel(
//                intId: 60,
//                strProductName: "Thandai",
//                strProductDescription: "Cold milk drink with spices & nuts",
//                floatProductRating: 4.7,
//                doubleProductPrice: 50.0,
//                strProductImage: "Ic_Thandai",
//                intTotalNumberOfRatings: 80,
//                objProductCategory: .Gujarati,
//                objProductType: .Beverages
//            ),
//            ProductModel(
//                intId: 61,
//                strProductName: "Margherita Pizza",
//                strProductDescription:
//                    "Classic pizza with tomato sauce, mozzarella, and basil",
//                floatProductRating: 4.8,
//                doubleProductPrice: 300.0,
//                strProductImage: "ic_margherita_pizza",
//                intTotalNumberOfRatings: 500,
//                objProductCategory: .WesternFood,
//                objProductType: .food
//            ),
//            ProductModel(
//                intId: 62,
//                strProductName: "Spaghetti Carbonara",
//                strProductDescription:
//                    "Pasta with creamy sauce, bacon, and parmesan",
//                floatProductRating: 4.7,
//                doubleProductPrice: 280.0,
//                strProductImage: "ic_spaghetti_carbonara",
//                intTotalNumberOfRatings: 420,
//                objProductCategory: .WesternFood,
//                objProductType: .food
//            ),
//            ProductModel(
//                intId: 63,
//                strProductName: "Cheeseburger",
//                strProductDescription:
//                    "Juicy beef patty with cheese, lettuce, and tomato",
//                floatProductRating: 4.6,
//                doubleProductPrice: 250.0,
//                strProductImage: "ic_cheese_burger",
//                intTotalNumberOfRatings: 600,
//                objProductCategory: .WesternFood,
//                objProductType: .food
//            ),
//            ProductModel(
//                intId: 64,
//                strProductName: "Grilled Chicken",
//                strProductDescription:
//                    "Tender chicken breast seasoned and grilled to perfection",
//                floatProductRating: 4.5,
//                doubleProductPrice: 270.0,
//                strProductImage: "ic_grilled_chicken",
//                intTotalNumberOfRatings: 350,
//                objProductCategory: .WesternFood,
//                objProductType: .food
//            ),
//            ProductModel(
//                intId: 65,
//                strProductName: "Fish and Chips",
//                strProductDescription: "Crispy battered fish served with fries",
//                floatProductRating: 4.6,
//                doubleProductPrice: 320.0,
//                strProductImage: "ic_fish_and_chips",
//                intTotalNumberOfRatings: 280,
//                objProductCategory: .WesternFood,
//                objProductType: .food
//            ),
//            // WesternFood Desserts (66–70)
//            ProductModel(
//                intId: 66,
//                strProductName: "Chocolate Brownie",
//                strProductDescription:
//                    "Rich chocolate dessert with a fudgy texture",
//                floatProductRating: 4.9,
//                doubleProductPrice: 120.0,
//                strProductImage: "ic_chocolate_brownie",
//                intTotalNumberOfRatings: 500,
//                objProductCategory: .WesternFood,
//                objProductType: .Desserts
//            ),
//            ProductModel(
//                intId: 67,
//                strProductName: "Cheesecake",
//                strProductDescription:
//                    "Creamy dessert with biscuit base and fruit topping",
//                floatProductRating: 4.8,
//                doubleProductPrice: 180.0,
//                strProductImage: "ic_cheesecake",
//                intTotalNumberOfRatings: 450,
//                objProductCategory: .WesternFood,
//                objProductType: .Desserts
//            ),
//            ProductModel(
//                intId: 68,
//                strProductName: "Apple Pie",
//                strProductDescription:
//                    "Classic pastry with cinnamon-spiced apple filling",
//                floatProductRating: 4.7,
//                doubleProductPrice: 150.0,
//                strProductImage: "ic_apple_pie",
//                intTotalNumberOfRatings: 400,
//                objProductCategory: .WesternFood,
//                objProductType: .Desserts
//            ),
//            ProductModel(
//                intId: 69,
//                strProductName: "Panna Cotta",
//                strProductDescription:
//                    "Italian creamy dessert served with fruit coulis",
//                floatProductRating: 4.6,
//                doubleProductPrice: 170.0,
//                strProductImage: "ic_panna_cotta",
//                intTotalNumberOfRatings: 320,
//                objProductCategory: .WesternFood,
//                objProductType: .Desserts
//            ),
//            ProductModel(
//                intId: 70,
//                strProductName: "Tiramisu",
//                strProductDescription:
//                    "Coffee-flavored Italian dessert with mascarpone",
//                floatProductRating: 4.9,
//                doubleProductPrice: 200.0,
//                strProductImage: "ic_tiramisu",
//                intTotalNumberOfRatings: 480,
//                objProductCategory: .WesternFood,
//                objProductType: .Desserts
//            ),
//            ProductModel(
//                intId: 71,
//                strProductName: "Cappuccino",
//                strProductDescription:
//                    "Espresso-based coffee with steamed milk foam",
//                floatProductRating: 4.8,
//                doubleProductPrice: 90.0,
//                strProductImage: "ic_cappuccino",
//                intTotalNumberOfRatings: 550,
//                objProductCategory: .WesternFood,
//                objProductType: .Beverages
//            ),
//            ProductModel(
//                intId: 72,
//                strProductName: "Latte",
//                strProductDescription:
//                    "Creamy espresso drink with steamed milk",
//                floatProductRating: 4.7,
//                doubleProductPrice: 100.0,
//                strProductImage: "ic_latte",
//                intTotalNumberOfRatings: 500,
//                objProductCategory: .WesternFood,
//                objProductType: .Beverages
//            ),
//            ProductModel(
//                intId: 73,
//                strProductName: "Hot Chocolate",
//                strProductDescription:
//                    "Rich and creamy cocoa drink topped with whipped cream",
//                floatProductRating: 4.9,
//                doubleProductPrice: 110.0,
//                strProductImage: "ic_hot_chocolate",
//                intTotalNumberOfRatings: 450,
//                objProductCategory: .WesternFood,
//                objProductType: .Beverages
//            ),
//            ProductModel(
//                intId: 74,
//                strProductName: "Iced Coffee",
//                strProductDescription: "Chilled coffee drink served over ice",
//                floatProductRating: 4.6,
//                doubleProductPrice: 80.0,
//                strProductImage: "ic_iced_coffee",
//                intTotalNumberOfRatings: 400,
//                objProductCategory: .WesternFood,
//                objProductType: .Beverages
//            ),
//            ProductModel(
//                intId: 75,
//                strProductName: "Lemon Iced Tea",
//                strProductDescription:
//                    "Refreshing tea served cold with lemon flavor",
//                floatProductRating: 4.5,
//                doubleProductPrice: 70.0,
//                strProductImage: "ic_lemon_iced_tea",
//                intTotalNumberOfRatings: 380,
//                objProductCategory: .WesternFood,
//                objProductType: .Beverages
//            ),
//        ]
//    }
}
enum ProductType: String,Codable {
    case food
    case Beverages
    case Desserts
}
enum ProductCategory: String, CaseIterable ,Codable{
    case All
    case Punjabi
    case Chinese
    case Gujarati
    case SouthIndian
    case WesternFood
}
