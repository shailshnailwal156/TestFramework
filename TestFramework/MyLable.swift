//
//  MyLable.swift
//  TestFramework
//
//  Created by Shailsh Nailwal on 06/07/20.
//  Copyright © 2020 Shailsh Nailwal. All rights reserved.
//

import UIKit


public enum SootheFonts: Int {
    case bold //0
    case book // 1
    case medium // 2
    case regular //3
    case light //4
    case system //5
    case tabBarButtonItem //6
    case contextMessage //7

    public init() {
      self = .regular
    }

    public init(value: Int) {
      var result: SootheFonts = SootheFonts()
        switch value {
        case SootheFonts.book.rawValue:
            result = SootheFonts.book
        case SootheFonts.medium.rawValue:
            result = SootheFonts.medium
        case SootheFonts.bold.rawValue:
            result = SootheFonts.bold
        case SootheFonts.regular.rawValue:
            result = SootheFonts.regular
        case SootheFonts.light.rawValue:
            result = SootheFonts.light
        case SootheFonts.system.rawValue:
            result = SootheFonts.system
        case SootheFonts.tabBarButtonItem.rawValue:
            result = SootheFonts.system
        case SootheFonts.contextMessage.rawValue:
            result = SootheFonts.system
        default:
            result = SootheFonts.regular
        }
      self = result
    }

    public init(value: SootheFonts) {
        self = SootheFonts(value: value.rawValue)
    }

    public func font(size: CGFloat) -> UIFont {
        switch self {
        case .book, .regular:
            return UIFont(name: "GothamHTF-Book", size: size)!
        case .medium:
            return UIFont(name: "GothamHTF-Medium", size: size)!
        case .bold:
            return UIFont(name: "GothamHTF-Bold", size: size)!
        case .light:
            return UIFont(name: "GothamHTF-Light", size: size)!
        case .system:
            return UIFont.systemFont(ofSize: size)
        case .tabBarButtonItem:
            return UIFont.systemFont(ofSize: size)
        case .contextMessage:
            return UIFont.systemFont(ofSize: size)
        }
    }

    /**
     * Function will set the application font of any view of type UILabel, UITextField, UITextView and UIButton
     */
    public func setApplicationFont(toView view: UIView) {
        if view is UILabel {
            (view as! UILabel).font = font(size: (view as! UILabel).font.pointSize)
        } else if view is UITextField {
            (view as! UITextField).font = font(size: (view as! UITextField).font?.pointSize ?? 0)
        } else if view is UITextView {
            (view as! UITextView).font = font(size: (view as! UITextView).font?.pointSize ?? 0)
        } else if view is UIButton {
            (view as! UIButton).titleLabel?.font = font(size: (view as! UIButton).titleLabel?.font.pointSize ?? 0)
        }
    }
}

@IBDesignable
public class MyLable: UILabel {
  var _font: SootheFonts = SootheFonts()
    public static var isFontRegistered = false
  @IBInspectable
  public var customFont: Int = SootheFonts.regular.rawValue {
     didSet {
        self._font = SootheFonts(value: customFont) //.init(value: customFont)
        self.font = _font.font(size: self.font.pointSize)
       setNeedsDisplay()
     }
  }
    
//    public required init?(coder: NSCoder) {
//
//        super.init(coder: coder)
//
//        if !MyLable.isFontRegistered {
//
//            MyLable.loadFonts()
//        }
//    }
    
    private static func registerFont(withName name: String, fileExtension: String) {
        let frameworkBundle = Bundle(for: MyLable.self)
        let pathForResourceString = frameworkBundle.path(forResource: name, ofType: fileExtension)
        let fontData = NSData(contentsOfFile: pathForResourceString!)
        let dataProvider = CGDataProvider(data: fontData!)
        let fontRef = CGFont(dataProvider!)
        var errorRef: Unmanaged<CFError>? = nil

        if (CTFontManagerRegisterGraphicsFont(fontRef!, &errorRef) == false) {
            print("Error registering font")
        }
    }

    public static func loadFonts() {
        registerFont(withName: "GothamHTF-Light", fileExtension: "ttf")
        registerFont(withName: "GothamHTF-Thin", fileExtension: "ttf")
        registerFont(withName: "GothamHTF-Medium", fileExtension: "ttf")
        registerFont(withName: "GothamHTF-Book", fileExtension: "ttf")
        registerFont(withName: "GothamHTF-Bold", fileExtension: "ttf")
        registerFont(withName: "GothamHTF-XLight", fileExtension: "ttf")
    }
}
