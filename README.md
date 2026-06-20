# dotfiles (chezmoi)

새 맥에서 복원:

```bash
brew install chezmoi
chezmoi init --apply https://github.com/mgook/dotfiles.git
```

## 자동으로 되는 것
- Homebrew 설치 (없으면)
- Brewfile 기반 패키지/앱 설치 (`run_onchange_install-packages.sh.tmpl`)
- zshrc, gitconfig, gitignore_global 적용
- starship, ghostty, cmux, karabiner 설정 파일 적용

## 수동으로 해야 하는 것

**계정/인증**
- iCloud Drive 로그인 → `1-Projects` 등 PARA 폴더 구조 자동으로 내려옴
- `gh auth login` → GitHub 인증 (브라우저 OAuth, 토큰은 git에 안 올림)
- App Store 로그인 후 `mas`로 설치된 앱 받기

**macOS 권한 (시스템 설정 > 개인정보 보호 및 보안)**
- 입력 모니터링: Karabiner-Elements, Logi Options+
- 손쉬운 사용(Accessibility): Karabiner-Elements, Logi Options+, Raycast
- 권한 허용 후 해당 앱 재시작 필요할 수 있음

**Raycast**
- `raycast/raycast-export.rayconfig` 파일을 Raycast 설정 → Advanced → Import로 불러오기
- Pro 구독 아니라서 클라우드 동기화 안 됨, 매번 수동 export/import 필요

**Logi Options+**
- 공식 export 기능 없음 → 마우스/키보드 버튼 매핑 새로 설정 (보통 5분)

**기타**
- 각 앱 자체 로그인 (Notion, Sunsama, Todoist, TickTick, Spark 등)
- Dock 배열, 트랙패드 속도, 디스플레이 배치 등은 수동 설정
