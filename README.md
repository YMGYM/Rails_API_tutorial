# Rails API 연습

- 본 프로젝트는 Ruby On Rails 를 사용한 API 연습 레포지토리입니다.
- '당신을 위한 맞춤형 헬스 서포트 - 오빠 오늘 뭐해요'프로젝트의 백엔드 API를 만들어 본다고 생각합니다.
- 진행에 필요한 API 내용은 아래에 정의되어 있습니다.

# 프로젝트 진행 목표
- Rails 백엔드를 사용해 서비스 코드를 완성
- 코드에 정성을 들여서 조금 더 깔끔한 코드를 짜는 것을 목표로 합니다.
- API 서비스 구현에 가장 가까운 방식으로 코드를 짜는 것을 목표로 합니다.

# 프로젝트 설명
- '당신을 위한 맞춤형 헬스 서포트 - 오빠 오늘 뭐해요'
- 최근 진행한 헬스 부위 또는 운동을 입력 받아서 오늘 진행하면 좋을 운동 부위를 산출
  - 프로젝트에는 간단한 알고리즘만 구현하여 사용함
  - 가슴, 팔, 어깨, 복근, 등, 하체 5가지 부분의 운동으로 구분하여 저장 후 **최근에 안해본 운동**으로 코스를 짜서 주는 것을 목표로 함
- 운동을 진행함에 따라서 추가적인 운동을 더 할 수 있습니다.
  - 운동을 할 수록 경험치가 쌓여 레벨업을 할 수 있습니다.
  
# 모델 구조 설명
모델의 구조는 다음을 포함합니다.
## Exercise
- 운동의 종류가 작성되어 있습니다.
- id
- title
- part(enum으로 작성): 운동을 한 부위
- tier_id: 운동을 할 수 있는 레벨을 저장하고 있습니다.
- content: 운동방법이 저장된 상세 내용

## User
- 운동을 하는 주체인 사용자가 정의되어 있습니다.
- id
- email
- tier_id: 사용자가 운동을 할 수 있는 레벨을 의미합니다.
  
## Workout
- 실제 운동을 한 데이터가 기록되어 있습니다.
- id
- exercise_id
- user_id
- work_time : 운동을 한 시간
- calorie_amount: 소모된 칼로리 양

## Tier
- 운동을 함에 따라서 레벨업이 가능한 경험치를 정의하고 있습니다.
- id
- level_name: (string) 현재 레벨에서 정의된 레벨의 이름
- calorie_amount: 레벨업을 하는 데 필요한 경험치(소모 칼로리)의 양


# API 설명
프로젝트에서 구현된 API 의 상세 설명입니다.
## 사용자 로그인
### 입력값
POST `/api/user/sign_in`
|이름|타입|설명|옵션|
|:---:|:---:|:---:|:---:|
|||||
사용자 계정으로 로그인합니다.

### 출력값
|이름|타입|설명|옵션|
|:---:|:---:|:---:|:---:|
|||||

### 오류 목록
|이름|타입|설명|옵션|
|:---:|:---:|:---:|:---:|
|||||

## 사용자 회원가입
### 입력값
POST `/api/user/sign_up`
|이름|타입|설명|옵션|
|:---:|:---:|:---:|:---:|
|||||
사용자 계정으로 로그인합니다.

### 출력값
|이름|타입|설명|옵션|
|:---:|:---:|:---:|:---:|
|||||

### 오류 목록
|이름|타입|설명|옵션|
|:---:|:---:|:---:|:---:|
|||||

## 전체 페이지
### 입력값
GET `/api/exercises`
|이름|타입|설명|옵션|
|:---:|:---:|:---:|:---:|
|||||
전체 운동 목록을 불러옵니다.

### 출력값
|이름|타입|설명|옵션|
|:---:|:---:|:---:|:---:|
|exercises|array|운동의 목록||

`exercises` 는 다음과 같은 구조입니다.
|이름|타입|설명|옵션|
|:---:|:---:|:---:|:---:|
|id|integer|운동의 id||
|title|string|운동의 이름||
|part|integer|운동할 범위||


### 오류 목록
|이름|타입|설명|옵션|
|:---:|:---:|:---:|:---:|
|||||

## 상세 운동 불러오기
### 입력값
GET `/api/exercises/:id`
|이름|타입|설명|옵션|
|:---:|:---:|:---:|:---:|
|-|-|-|-|
특정 id 의 운동 정보를 불러옵니다.

### 출력값
|이름|타입|설명|옵션|
|:---:|:---:|:---:|:---:|
|id|integer|운동의 id||
|title|string|운동의 이름||
|part|integer|운동할 범위||
|content|text|운동의 상세 내용||

### 오류 목록
|이름|타입|설명|옵션|
|:---:|:---:|:---:|:---:|
|||||

## 추천 운동 루틴 불러오기
### 입력값
GET `/api/recommend/:id`
|이름|타입|설명|옵션|
|:---:|:---:|:---:|:---:|
|usre_id|integer|사용자의 id||

사용자의 입력 정보를 받아와 이에 맞는 운동 루틴을 설정합니다.
추가적인 입력값은 현재 생략합니다.

### 출력값
|이름|타입|설명|옵션|
|:---:|:---:|:---:|:---:|
|exercises|array|운동의 목록||

`exercises` 는 다음과 같은 구조입니다.
|이름|타입|설명|옵션|
|:---:|:---:|:---:|:---:|
|id|integer|운동의 id||
|title|string|운동의 이름||
|part|integer|운동할 범위||


### 오류 목록
|이름|타입|설명|옵션|
|:---:|:---:|:---:|:---:|
|||||


## 운동 실행 결과 입력하기
### 입력값
POST `/api/workout/:id`
|이름|타입|설명|옵션|
|:---:|:---:|:---:|:---:|
|user_id|integer|사용자 id||
|exercise_id|integer|운동 id||
|work_time|integer|운동한 시간||
|calorie_amount|integer|소모된 칼로리||

사용자가 운동을 완료하면 결과를 기록하고 저장합니다.

### 출력값
|이름|타입|설명|옵션|
|:---:|:---:|:---:|:---:|
|status|string|'OK'||

### 오류 목록
|이름|타입|설명|옵션|
|:---:|:---:|:---:|:---:|
|||||