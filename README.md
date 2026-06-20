# mac-setup (chezmoi)

새 맥에서 복원:

```bash
brew install chezmoi
chezmoi init --apply https://github.com/mgook/mac-setup.git
```

이 한 줄로 자동 처리됨:
- Homebrew 설치 (없으면 자동 설치, `run_onchange_install-packages.sh.tmpl`이 처리)
- Brewfile 기반 패키지/앱 전체 설치
- zshrc, gitconfig, gitignore_global 적용
- starship, ghostty, cmux, **karabiner.json**(Caps Lock/Control→F19 매핑 포함) 적용

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

### F19 → 한영 전환 (CrossEX)
Caps Lock/Control가 F19로 바뀌는 건 karabiner.json에 있지만, **F19를 눌렀을 때 실제로 한영 전환이 되는 건 macOS 설정이 아니라 iniLINE의 CrossEX라는 별도 백그라운드 서비스 때문**. 이건 Homebrew 패키지가 아니라서 Brewfile에 없고 자동 설치 안 됨.
- [ ] CrossEX 설치 (iniLINE 공식 사이트에서 다운로드, 설치 후 로그인 시 자동 실행되는 LaunchAgent 등록됨)
- [ ] 설치 후 F19로 한영 전환 잘 되는지 확인 (안 되면 CrossEX 자체 설정에서 키 재지정 필요할 수 있음 — 포터블 설정 파일을 못 찾아서 chezmoi로 옮길 수 없었음)

### Logi Options+
- [ ] 입력 모니터링 + 손쉬운 사용 권한 허용
- [ ] 공식 export 기능 없어서 마우스/키보드 버튼 매핑은 새로 설정 (5분 내)

### Raycast
- [ ] 손쉬운 사용 권한 허용 (전역 핫키 작동용)
- [ ] `raycast/raycast-export.rayconfig` 파일을 Raycast 설정 → Advanced → Import로 불러오기
- Pro 구독 아니라서 클라우드 동기화 안 됨, 매번 수동 export/import 필요

### 그 외
- [ ] 각 앱 자체 로그인 (Notion, Sunsama, Todoist, TickTick, Spark 등)
- [ ] Dock 배열, 트랙패드 속도, 디스플레이 배치 등 수동 설정
- [ ] brew tap `hamed-elfayome/claude-usage` 신뢰 여부 확인 (`brew trust` 필요할 수 있음, 서드파티 tap)
