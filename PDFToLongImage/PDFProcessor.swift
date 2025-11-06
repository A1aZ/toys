//
//  PDFProcessor.swift
//  PDFToLongImage
//
//  PDF 处理核心功能
//

import Foundation
import AppKit
import PDFKit

class PDFProcessor {
    
    /// 将 PDF 文件转换为图片数组
    /// - Parameters:
    ///   - pdfURL: PDF 文件路径
    ///   - scale: 缩放比例（默认 2.0，提供更清晰的图片）
    /// - Returns: 图片数组
    static func convertPDFToImages(pdfURL: URL, scale: CGFloat = 2.0) -> [NSImage]? {
        guard let pdfDocument = PDFDocument(url: pdfURL) else {
            return nil
        }
        
        var images: [NSImage] = []
        let pageCount = pdfDocument.pageCount
        
        for pageIndex in 0..<pageCount {
            guard let page = pdfDocument.page(at: pageIndex) else {
                continue
            }
            
            let pageRect = page.bounds(for: .mediaBox)
            let renderer = NSBitmapImageRep(
                bitmapDataPlanes: nil,
                pixelsWide: Int(pageRect.width * scale),
                pixelsHigh: Int(pageRect.height * scale),
                bitsPerSample: 8,
                samplesPerPixel: 4,
                hasAlpha: true,
                isPlanar: false,
                colorSpaceName: .calibratedRGB,
                bytesPerRow: 0,
                bitsPerPixel: 0
            )
            
            guard let imageRep = renderer else {
                continue
            }
            
            let context = NSGraphicsContext(bitmapImageRep: imageRep)
            NSGraphicsContext.saveGraphicsState()
            NSGraphicsContext.current = context
            
            context?.cgContext.scaleBy(x: scale, y: scale)
            page.draw(with: .mediaBox, to: context!.cgContext)
            
            NSGraphicsContext.restoreGraphicsState()
            
            let image = NSImage(size: pageRect.size)
            image.addRepresentation(imageRep)
            images.append(image)
        }
        
        return images.isEmpty ? nil : images
    }
    
    /// 将多个图片垂直拼接成长图
    /// - Parameter images: 图片数组
    /// - Returns: 拼接后的长图
    static func combineImagesVertically(images: [NSImage]) -> NSImage? {
        guard !images.isEmpty else {
            return nil
        }
        
        // 计算总高度和最大宽度
        var totalHeight: CGFloat = 0
        var maxWidth: CGFloat = 0
        
        for image in images {
            totalHeight += image.size.height
            maxWidth = max(maxWidth, image.size.width)
        }
        
        // 创建新的图片
        let combinedImage = NSImage(size: NSSize(width: maxWidth, height: totalHeight))
        combinedImage.lockFocus()
        
        var currentY: CGFloat = totalHeight
        
        for image in images {
            let rect = NSRect(
                x: (maxWidth - image.size.width) / 2,  // 居中对齐
                y: currentY - image.size.height,
                width: image.size.width,
                height: image.size.height
            )
            image.draw(in: rect)
            currentY -= image.size.height
        }
        
        combinedImage.unlockFocus()
        
        return combinedImage
    }
    
    /// 将图片保存为文件
    /// - Parameters:
    ///   - image: 要保存的图片
    ///   - url: 保存路径
    /// - Returns: 是否保存成功
    static func saveImage(image: NSImage, to url: URL) -> Bool {
        guard let tiffData = image.tiffRepresentation,
              let bitmapImage = NSBitmapImageRep(data: tiffData),
              let pngData = bitmapImage.representation(using: .png, properties: [:]) else {
            return false
        }
        
        do {
            try pngData.write(to: url)
            return true
        } catch {
            print("保存图片失败: \(error)")
            return false
        }
    }
    
    /// 主处理函数：将 PDF 转换为长图
    /// - Parameters:
    ///   - pdfURL: PDF 文件路径
    ///   - outputURL: 输出图片路径
    ///   - scale: 缩放比例
    /// - Returns: 是否成功
    static func convertPDFToLongImage(pdfURL: URL, outputURL: URL, scale: CGFloat = 2.0) -> Bool {
        guard let images = convertPDFToImages(pdfURL: pdfURL, scale: scale),
              let longImage = combineImagesVertically(images: images) else {
            return false
        }
        
        return saveImage(image: longImage, to: outputURL)
    }
}
