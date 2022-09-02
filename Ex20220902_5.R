df1 <- data.frame(x = 1:5, y = rnorm(5))
df2 <- data.frame(x = 2:6, z = rnorm(5))
df1
df2
inner_join(df1,df2, by = 'x')                  # 공통되는 x에 대해 조인
left_join(df1,df2, by = 'x')                   # df1에 df2를 붙이는데 x값이 중첩되는 행만!
right_join(df1,df2, by = 'x')                  # df2에 df1을 붙이는데 x값이 중첩되는 행만!
full_join(df1,df2, by = 'x')                   # 모든 x에 대해 조인

df1 <- data.frame(x = 1:5, y = rnorm(5))
df2 <- data.frame(x = 6:10, y = rnorm(5))
df3 <- data.frame(z = 1:5)
bind_rows(df1, df2)
df_cols <- bind_cols(df1,df3)

df_rename <- rename(df_cols, x1 = x)           # 원본은 그대로, 바꾼 정보를 df_rename에 저장
df_rename                                     


# iris 에서 3 품종을 각각 df1, df2, df3 에 저장
# df_all 변수에 행단위 병합(vir, ver, set 순서)
df1 <- iris %>% filter(Species == "setosa")
df2 <- iris %>% filter(Species == "versicolor")
df3 <- iris %>% filter(Species == "virginica")

df_all <- bind_rows(df3, df2, df1)
df_all
