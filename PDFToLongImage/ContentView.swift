//
//  ContentView.swift
//  PDFToLongImage
//
//  主界面
//

import SwiftUI

struct ContentView: View {
    @State private var selectedPDFURL: URL?
    @State private var isProcessing = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var alertTitle = ""
    @State private var progress: Double = 0
    
    var body: some View {
        VStack(spacing: 20) {
            // 标题
            Text("PDF 转长图")
                .font(.system(size: 24, weight: .bold))
                .padding(.top, 30)
            
            // 文件选择区域
            VStack(spacing: 15) {
                if let pdfURL = selectedPDFURL {
                    VStack(spacing: 8) {
                        Image(systemName: "doc.fill")
                            .font(.system(size: 48))
                            .foregroundColor(.blue)
                        Text(pdfURL.lastPathComponent)
                            .font(.system(size: 14))
                            .lineLimit(1)
                            .truncationMode(.middle)
                            .frame(maxWidth: 300)
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                } else {
                    VStack(spacing: 8) {
                        Image(systemName: "doc")
                            .font(.system(size: 48))
                            .foregroundColor(.gray)
                        Text("未选择 PDF 文件")
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                }
                
                Button(action: selectPDF) {
                    HStack {
                        Image(systemName: "folder")
                        Text("选择 PDF 文件")
                    }
                    .frame(width: 200)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                }
                .buttonStyle(.plain)
                .disabled(isProcessing)
            }
            .padding(.horizontal, 40)
            
            // 进度条
            if isProcessing {
                VStack(spacing: 8) {
                    ProgressView(value: progress)
                        .progressViewStyle(.linear)
                    Text("正在处理...")
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                }
                .padding(.horizontal, 40)
            }
            
            // 转换按钮
            Button(action: convertPDF) {
                HStack {
                    if isProcessing {
                        ProgressView()
                            .progressViewStyle(.circular)
                            .scaleEffect(0.8)
                    } else {
                        Image(systemName: "arrow.triangle.2.circlepath")
                    }
                    Text(isProcessing ? "处理中..." : "转换为长图")
                }
                .frame(width: 200)
                .padding()
                .background(selectedPDFURL != nil && !isProcessing ? Color.green : Color.gray)
                .foregroundColor(.white)
                .cornerRadius(8)
            }
            .buttonStyle(.plain)
            .disabled(selectedPDFURL == nil || isProcessing)
            
            Spacer()
        }
        .frame(width: 500, height: 400)
        .alert(alertTitle, isPresented: $showAlert) {
            Button("确定", role: .cancel) { }
        } message: {
            Text(alertMessage)
        }
    }
    
    private func selectPDF() {
        let panel = NSOpenPanel()
        panel.allowsMultipleSelection = false
        panel.canChooseDirectories = false
        panel.canChooseFiles = true
        panel.allowedContentTypes = [.pdf]
        panel.title = "选择 PDF 文件"
        
        if panel.runModal() == .OK {
            selectedPDFURL = panel.url
        }
    }
    
    private func convertPDF() {
        guard let pdfURL = selectedPDFURL else {
            return
        }
        
        isProcessing = true
        progress = 0.3
        
        // 选择保存位置
        let savePanel = NSSavePanel()
        savePanel.allowedContentTypes = [.png]
        savePanel.nameFieldStringValue = pdfURL.deletingPathExtension().lastPathComponent + "_长图"
        savePanel.title = "保存长图"
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            if savePanel.runModal() == .OK {
                guard let outputURL = savePanel.url else {
                    isProcessing = false
                    displayAlert(title: "错误", message: "未选择保存位置")
                    return
                }
                
                progress = 0.5
                
                // 在后台线程处理
                DispatchQueue.global(qos: .userInitiated).async {
                    let success = PDFProcessor.convertPDFToLongImage(
                        pdfURL: pdfURL,
                        outputURL: outputURL,
                        scale: 2.0
                    )
                    
                    DispatchQueue.main.async {
                        isProcessing = false
                        progress = 0
                        
                        if success {
                            displayAlert(title: "成功", message: "PDF 已成功转换为长图！\n保存位置: \(outputURL.path)")
                        } else {
                            displayAlert(title: "失败", message: "转换失败，请检查 PDF 文件是否有效。")
                        }
                    }
                }
            } else {
                isProcessing = false
                progress = 0
            }
        }
    }
    
    private func displayAlert(title: String, message: String) {
        alertTitle = title
        alertMessage = message
        showAlert = true
    }
}
