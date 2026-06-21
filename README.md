# mac-setup (chezmoi)

새 맥에서 복원:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" && \
eval "$(/opt/homebrew/bin/brew shellenv)" && \
brew install chezmoi && \
chezmoi init --apply https://github.com/mgook/mac-setup.git
```

(Homebrew를 먼저 설치해서 chezmoi도 brew로 관리 — get.chezmoi.io 자체 설치 스크립트를 쓰면 brew 관리 밖에 깔려서 나중에 `brew upgrade`로 안 잡힘)

이 한 줄로 자동 처리됨:
- Homebrew 설치 (없으면 자동 설치, `run_onchange_install-packages.sh.tmpl`이 처리)
- Brewfile 기반 패키지/앱 전체 설치
- zshrc, gitconfig, gitignore_global 적용
- starship, ghostty, cmux, **karabiner.json**(Caps Lock/Control→F19 매핑 포함) 적용
- raycast 폴더의 Script Commands(ps5.sh, dual.sh) 적용
- **F19 → "입력 메뉴에서 다음 소스 선택" 단축키 자동 설정** (`run_once_set-f19-input-source-hotkey.sh`, 재로그인 후 적용됨)

## 새 프로그램 설치 후 — dotfile 추가하는 법

chezmoi는 새로 생긴 설정 파일을 자동으로 잡아주지 않음. 새 프로그램 설치할 때마다 직접 확인해서 추가해야 함.

```bash
# 1. 새 프로그램 설치
brew install --cask 무슨앱

# 2. 추적 안 되고 있는 파일 확인 (대부분 캐시/노이즈, 설정 파일만 골라보기)
chezmoi unmanaged ~/.config
chezmoi unmanaged ~

# 3. 의미있는 설정 파일이면 추가
chezmoi add ~/.config/무슨앱/config.toml

# 4. 커밋 & 푸시
chezmoi cd && git add -A && git commit -m "add 무슨앱 config" && git push
```

`~/Library/Application Support`, `~/Library/Preferences`에 있는 건 대부분 캐시/세션/텔레메트리/사용 기록이라 그대로 추가하면 안 됨 (예: 브라우저 히스토리, 검색 인덱스). 진짜 사용자가 편집하는 설정 파일인지 확인하고 추가할 것.

## 수동으로 해야 하는 것

### 계정/인증
- [ ] iCloud Drive 로그인 → `1-Projects` 등 PARA 폴더 구조 자동으로 내려옴
- [ ] `gh auth login` → GitHub 인증 (브라우저 OAuth, 토큰은 git에 안 올림)
- [ ] App Store 로그인 후 `mas`로 설치된 앱 받기

### Karabiner-Elements (중요 — 설정 파일만으론 안 작동함)
설정 파일(`karabiner.json`)은 자동으로 들어가지만, 다음을 **반드시 직접 승인**해야 실제로 동작함:
- [ ] 첫 실행 시 뜨는 "Karabiner-DriverKit-VirtualHIDDevice" 시스템 확장 설치 승인 (시스템 설정에서 별도 클릭 필요, 재부팅 요구될 수 있음)
- [ ] 시스템 설정 → 개인정보 보호 및 보안 → **입력 모니터링**: karabiner_grabber, karabiner_observer 허용
- [ ] 시스템 설정 → 개인정보 보호 및 보안 → **손쉬운 사용**: Karabiner-Elements 허용
- 승인 후 Karabiner-Elements 재시작하면 Caps Lock/Control→F19 매핑 정상 작동

### F19 → 한영 전환
~~CrossEX 때문인 줄 알았으나 확인 결과 무관함.~~ 실제로는 macOS 자체 기능 (시스템 설정 → 키보드 → 입력 소스 → "입력 메뉴에서 다음 소스 선택" = F19). `com.apple.symbolichotkeys.plist`에 저장되는 값이라 `run_once_set-f19-input-source-hotkey.sh`로 자동 복원되도록 처리함. 별도 수동 작업 불필요.

CrossEX(iniLINE)는 이 머신에 설치되어 있긴 한데, 설치 로그 확인 결과 **2025-11-20에 다른 설치 프로그램(추정: 은행/공공기관 보안 프로그램 묶음)에 의해 같이 깔린 것으로 보임** — 같은 경로에 RaonSecure의 TouchEn nxKey(뱅킹 보안 모듈)도 같이 있었음. F19 한영 전환과는 무관해 보이니 mac-setup에는 포함 안 함. 필요 없으면 제거 검토해도 될 듯.

### Logi Options+
- [ ] 입력 모니터링 + 손쉬운 사용 권한 허용
- [ ] 공식 export 기능 없어서 마우스/키보드 버튼 매핑은 새로 설정 (5분 내)

### Raycast
- [ ] 손쉬운 사용 권한 허용 (전역 핫키 작동용)
- [ ] `raycast-export/raycast-export.rayconfig` 파일을 Raycast 설정 → Advanced → Import로 불러오기
- Pro 구독 아니라서 클라우드 동기화 안 됨, 매번 수동 export/import 필요

### 그 외
- [ ] 각 앱 자체 로그인 (Notion, Sunsama, Todoist, TickTick, Spark 등)
- [ ] Dock 배열, 트랙패드 속도, 디스플레이 배치 등 수동 설정
- [ ] claude-usage-tracker 필요하면 별도 설치 (서드파티 tap이라 Brewfile에서 제외함 — 직접 설치 시 `brew tap hamed-elfayome/claude-usage && brew trust hamed-elfayome/claude-usage`로 신뢰 승인 필요)
