# CV 및 프로필 업데이트 적용

기존 사이트 전체를 교체하지 않고 아래 두 파일만 적용합니다.

1. 기존 `src/data/profile.json`과 `src/pages/cv.astro`를 프로젝트 바깥 폴더에 백업합니다.
2. 이 압축 파일의 동일 경로에 있는 두 파일을 기존 프로젝트로 복사합니다. 이미 직접 수정한 소개나 사진 설정이 있다면 VS Code에서 비교하고 필요한 부분만 합치세요.
3. `npm run dev`로 확인하고, `npm run build`로 배포용 빌드를 확인합니다.

## 사진 추가

프로젝트 안에 `public/images` 폴더를 만든 뒤 본인 사진을 `profile.jpg`로 넣습니다. PNG라면 확장자를 그대로 사용하세요. `src/data/profile.json`에서 아래 항목을 수정합니다.

```json
"photo": "images/profile.jpg"
```

`public/`은 경로에 넣지 않습니다. Linux 파일명은 대소문자를 구분합니다. 사진을 첨부받지 않았으므로 업데이트 파일은 `photo`를 빈 값으로 둡니다.

사진은 홈 화면에 표시됩니다. 기존 `.portrait` CSS의 `object-fit: cover`는 사진 가장자리를 자를 수 있습니다. 원본 전체가 보이게 하려면 `src/styles/global.css`의 마지막에 아래를 추가합니다.

```css
.portrait { height: auto; object-fit: contain; }
```

## 내용 수정·삭제

모든 CV 항목은 `src/data/profile.json`에 있습니다. 항목별 `{ ... }` 객체를 삭제하면 해당 경력이 사라집니다. 구분 쉼표도 맞춰 주세요. 섹션 전체를 숨기려면 해당 배열을 `[]`로 설정하세요. 예: `"manuscripts": []`. 속성 이름은 유지하고 배열을 비우는 방식을 권장합니다. CV의 빈 섹션 제목도 자동으로 숨겨집니다. 소개의 `about` 배열은 문단별 문자열입니다. 프로젝트 목록은 별도 `src/data/projects.json`에서 수정합니다.

## 이번 반영 내용

- 첨부 CV의 DGIST 학력, 학점, Cum Laude, 졸업논문을 반영했습니다.
- ADD 소속·직책·시작일과 연구/업무 경력을 반영했습니다.
- 학회 포스터 3건 및 프로그래밍·기술·도구·데이터셋 목록을 추가했습니다.
- 이전 대화에서 전달된 심사 결과와 맞지 않는 `Under review at CoRL 2026` 표기는 제외했습니다. BeTraVL은 게재·심사 상태를 단정하지 않는 Manuscripts 섹션에 표시합니다.
- 공개 연락처는 CV의 이메일만 반영했고 전화번호는 추가하지 않았습니다.
- 원본 PDF는 수정하지 않았고, Projects 페이지의 독립 학습 프로젝트도 삭제하지 않았습니다. CV에 없다는 이유만으로 잘못된 정보로 판단하지 않았습니다.

## PDF 다운로드 링크

기존 PDF에는 CoRL 심사 중 표기가 남아 있습니다. 원본 CV를 최신화한 다음 `public/cv.pdf`로 복사하고 `"cvPdf": "cv.pdf"`로 설정하면 CV 페이지에 다운로드 링크가 나타납니다. JSON 수정은 PDF 파일 내용을 변경하지 않습니다.
