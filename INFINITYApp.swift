import SwiftUI

@main
struct INFINITYApp: App {
    var body: some Scene {
        WindowGroup { ContentView() }
    }
}

struct ContentView: View {
    @State private var menuOpen = true
    @State private var compact = false
    @State private var transparency = 0.94
    @State private var haptics = true
    @State private var notifications = false
    @State private var selectedTab = 0
    @State private var toggles: [String: Bool] = [
        "Hiệu ứng phát sáng": true,
        "Rung khi chạm": true,
        "Thông báo": false,
        "Hiển thị trạng thái": true
    ]

    private let purple = Color(red: 0.66, green: 0.35, blue: 1.0)
    private let bg = Color(red: 0.055, green: 0.045, blue: 0.085)

    var body: some View {
        ZStack {
            LinearGradient(colors: [bg, Color(red: 0.10, green: 0.055, blue: 0.16), .black], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            Circle().fill(purple.opacity(0.13)).frame(width: 270).blur(radius: 65).offset(x: 130, y: -280)
            VStack(spacing: 22) {
                header
                if menuOpen {
                    VStack(spacing: 0) {
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("INFINITY").font(.system(size: 23, weight: .black, design: .rounded)).tracking(2)
                                Text("CONTROL CENTER  •  DEMO").font(.system(size: 9, weight: .bold)).tracking(1.5).foregroundStyle(.white.opacity(0.48))
                            }
                            Spacer()
                            Image(systemName: "infinity").font(.system(size: 31, weight: .bold)).foregroundStyle(purple)
                        }.padding(18)
                        Rectangle().fill(.white.opacity(0.09)).frame(height: 1)
                        HStack(spacing: 8) {
                            tabButton("Tổng quan", icon: "square.grid.2x2.fill", index: 0)
                            tabButton("Giao diện", icon: "slider.horizontal.3", index: 1)
                            tabButton("Cài đặt", icon: "gearshape.fill", index: 2)
                        }.padding(12)
                        Rectangle().fill(.white.opacity(0.07)).frame(height: 1)
                        if selectedTab == 0 { overview } else if selectedTab == 1 { appearance } else { settings }
                        HStack {
                            Circle().fill(Color.green).frame(width: 7, height: 7)
                            Text("ỨNG DỤNG ĐỘC LẬP • ĐANG HOẠT ĐỘNG").font(.system(size: 9, weight: .bold)).tracking(0.7).foregroundStyle(.white.opacity(0.45))
                            Spacer()
                            Text("v1.0").font(.system(size: 10, weight: .bold, design: .monospaced)).foregroundStyle(purple)
                        }.padding(15)
                    }
                    .background(.ultraThinMaterial)
                    .background(Color(red: 0.075, green: 0.065, blue: 0.11).opacity(transparency))
                    .clipShape(RoundedRectangle(cornerRadius: 23))
                    .overlay(RoundedRectangle(cornerRadius: 23).stroke(purple.opacity(0.42), lineWidth: 1))
                    .shadow(color: purple.opacity(0.14), radius: 24)
                    .padding(.horizontal, 18)
                    .transition(.opacity.combined(with: .scale(scale: 0.97)))
                } else {
                    Button { withAnimation(.spring(response: 0.32)) { menuOpen = true } } label: {
                        HStack(spacing: 12) { Image(systemName: "infinity").font(.system(size: 26, weight: .bold)); Text("MỞ INFINITY").font(.system(size: 13, weight: .heavy)).tracking(1.4) }
                            .foregroundStyle(.white).padding(.horizontal, 22).padding(.vertical, 16)
                            .background(purple.opacity(0.18)).clipShape(Capsule()).overlay(Capsule().stroke(purple.opacity(0.8), lineWidth: 1))
                    }
                }
                Spacer(minLength: 0)
                Text("BẢN DEMO GIAO DIỆN — KHÔNG TÁC ĐỘNG VÀO GAME")
                    .font(.system(size: 9, weight: .semibold)).tracking(0.8).foregroundStyle(.white.opacity(0.28)).multilineTextAlignment(.center).padding(.bottom, 12)
            }
            .padding(.top, 14)
        }
        .preferredColorScheme(.dark)
    }

    private var header: some View {
        HStack(spacing: 12) {
            ZStack {
                RoundedRectangle(cornerRadius: 15).fill(LinearGradient(colors: [purple, Color(red: 0.35, green: 0.15, blue: 0.7)], startPoint: .topLeading, endPoint: .bottomTrailing)).frame(width: 49, height: 49)
                Image(systemName: "infinity").font(.system(size: 29, weight: .black)).foregroundStyle(.white)
            }
            VStack(alignment: .leading, spacing: 3) {
                Text("INFINITY").font(.system(size: 19, weight: .black, design: .rounded)).tracking(2)
                Text("DARK • MINIMAL • PURPLE").font(.system(size: 9, weight: .bold)).tracking(1.1).foregroundStyle(.white.opacity(0.45))
            }
            Spacer()
            Button { withAnimation(.spring(response: 0.32)) { menuOpen.toggle() } } label: {
                Image(systemName: menuOpen ? "minus" : "square.grid.2x2.fill").font(.system(size: 15, weight: .bold)).foregroundStyle(.white).frame(width: 42, height: 42).background(.white.opacity(0.07)).clipShape(RoundedRectangle(cornerRadius: 13)).overlay(RoundedRectangle(cornerRadius: 13).stroke(.white.opacity(0.1), lineWidth: 1))
            }
        }.padding(.horizontal, 20)
    }

    private var overview: some View {
        VStack(spacing: 12) {
            HStack(spacing: 10) {
                statCard(icon: "paintpalette.fill", title: "CHỦ ĐỀ", value: "Violet", color: purple)
                statCard(icon: "square.stack.3d.up.fill", title: "BỐ CỤC", value: compact ? "Gọn" : "Đầy đủ", color: .cyan)
            }
            VStack(spacing: 0) {
                toggleRow("Hiệu ứng phát sáng", subtitle: "Viền tím nhẹ", icon: "sparkles")
                divider
                toggleRow("Rung khi chạm", subtitle: "Phản hồi thao tác", icon: "iphone.gen3.radiowaves.left.and.right")
                divider
                toggleRow("Thông báo", subtitle: "Thông báo trong ứng dụng", icon: "bell.badge")
                divider
                toggleRow("Hiển thị trạng thái", subtitle: "Trạng thái demo", icon: "waveform.path")
            }.padding(.horizontal, 14).background(.white.opacity(0.035)).clipShape(RoundedRectangle(cornerRadius: 16)).overlay(RoundedRectangle(cornerRadius: 16).stroke(.white.opacity(0.07), lineWidth: 1))
        }.padding(14)
    }

    private var appearance: some View {
        VStack(alignment: .leading, spacing: 18) {
            Text("TÙY CHỈNH GIAO DIỆN").font(.system(size: 10, weight: .heavy)).tracking(1.4).foregroundStyle(.white.opacity(0.55))
            HStack { Label("Độ trong suốt", systemImage: "circle.lefthalf.filled").font(.system(size: 13, weight: .medium)); Spacer(); Text("\(Int(transparency * 100))%").font(.system(size: 12, weight: .bold, design: .monospaced)).foregroundStyle(purple) }
            Slider(value: $transparency, in: 0.65...1).tint(purple)
            Toggle(isOn: $compact) { Label("Bố cục gọn", systemImage: "rectangle.compress.vertical").font(.system(size: 13, weight: .medium)) }.tint(purple)
            HStack(spacing: 10) {
                ForEach([Color(red: 0.66, green: 0.35, blue: 1), .cyan, .pink], id: \.self) { color in RoundedRectangle(cornerRadius: 10).fill(color.gradient).frame(height: 35).overlay(Image(systemName: "checkmark").foregroundStyle(.white).font(.system(size: 12, weight: .black))) }
            }
        }.padding(18)
    }

    private var settings: some View {
        VStack(spacing: 0) {
            settingRow("Ngôn ngữ", value: "Tiếng Việt", icon: "globe")
            divider
            settingRow("Phiên bản", value: "1.0.0 Demo", icon: "info.circle")
            divider
            settingRow("Quyền riêng tư", value: "Cục bộ trên thiết bị", icon: "lock.shield")
            Text("Các công tắc chỉ minh họa tính năng giao diện trong ứng dụng INFINITY.").font(.system(size: 11)).foregroundStyle(.white.opacity(0.45)).frame(maxWidth: .infinity, alignment: .leading).padding(.top, 16)
        }.padding(16)
    }

    private var divider: some View { Rectangle().fill(.white.opacity(0.07)).frame(height: 1) }

    private func tabButton(_ title: String, icon: String, index: Int) -> some View {
        Button { withAnimation(.easeInOut(duration: 0.18)) { selectedTab = index } } label: {
            VStack(spacing: 6) { Image(systemName: icon).font(.system(size: 15, weight: .bold)); Text(title).font(.system(size: 9, weight: .bold)) }
                .foregroundStyle(selectedTab == index ? .white : .white.opacity(0.45)).frame(maxWidth: .infinity).padding(.vertical, 10)
                .background(selectedTab == index ? purple.opacity(0.24) : .clear).clipShape(RoundedRectangle(cornerRadius: 12))
        }.buttonStyle(.plain)
    }

    private func statCard(icon: String, title: String, value: String, color: Color) -> some View {
        HStack(spacing: 10) { Image(systemName: icon).font(.system(size: 17, weight: .bold)).foregroundStyle(color).frame(width: 36, height: 36).background(color.opacity(0.13)).clipShape(RoundedRectangle(cornerRadius: 10)); VStack(alignment: .leading, spacing: 4) { Text(title).font(.system(size: 8, weight: .heavy)).tracking(1).foregroundStyle(.white.opacity(0.42)); Text(value).font(.system(size: 13, weight: .bold)) } }.frame(maxWidth: .infinity, alignment: .leading).padding(12).background(.white.opacity(0.035)).clipShape(RoundedRectangle(cornerRadius: 15)).overlay(RoundedRectangle(cornerRadius: 15).stroke(.white.opacity(0.06), lineWidth: 1))
    }

    private func toggleRow(_ title: String, subtitle: String, icon: String) -> some View {
        HStack(spacing: 11) {
            Image(systemName: icon).font(.system(size: 15, weight: .semibold)).foregroundStyle(purple).frame(width: 34, height: 34).background(purple.opacity(0.12)).clipShape(RoundedRectangle(cornerRadius: 10))
            VStack(alignment: .leading, spacing: 3) { Text(title).font(.system(size: 12, weight: .semibold)); Text(subtitle).font(.system(size: 10)).foregroundStyle(.white.opacity(0.42)) }
            Spacer(minLength: 6)
            Toggle(title, isOn: Binding(get: { toggles[title, default: false] }, set: { toggles[title] = $0 })).labelsHidden().tint(purple).scaleEffect(0.82, anchor: .trailing)
        }.padding(.vertical, 11)
    }

    private func settingRow(_ title: String, value: String, icon: String) -> some View {
        HStack(spacing: 11) { Image(systemName: icon).foregroundStyle(purple).frame(width: 25); Text(title).font(.system(size: 12, weight: .medium)); Spacer(); Text(value).font(.system(size: 11)).foregroundStyle(.white.opacity(0.45)); Image(systemName: "chevron.right").font(.system(size: 9, weight: .bold)).foregroundStyle(.white.opacity(0.25)) }.padding(.vertical, 14)
    }
}
