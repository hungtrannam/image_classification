''' Các hàm được định nghĩa trong gói chương trình
1) Tính hệ số VIF
2) Tính hệ số tương quan Pearson và p-value tương ứng
3) Trực quan hóa hệ số tương quan Pearson bằng mô hình mạng (network)
4) Trực quan hóa hệ số tương quan Pearson bằng heatmap
'''

#1
def VIF(X):
    '''
    Hàm thực hiện tính hệ số VIF
    # Input: pandas dataframe 
    # Output: bảng VIF đối với mỗi biến
    '''
    # Chương trình tính hệ số VIF có trong statsmodels
    from statsmodels.stats.outliers_influence import variance_inflation_factor 
    
    vif_data = pd.DataFrame()
    vif_data["feature"] = X.columns
    
    # Tính hệ số VIF cho mỗi biến được nhập vào
    vif_data["VIF"] = [variance_inflation_factor(X.values, i) for i in range(len(X.columns))]
    
    print('Nhân tử phóng xạ phương sai (VIF) đối với mỗi biến X')
    print('='*40)
    print(vif_data)
    print('='*40)


#2
def correlation_matrix(df = None, method = 'pearson'):
    '''
    Hàm thực hiện phân tích tương quan
    # Input: pandas dataframe 
    # Arguments: df = pandas dataframe chứa datatype là int hoặc float
                 method = string, giá trị có thể: 'pearson', 'spearman'
    # Output: 2 matrices r và p_vals
    '''
    # Chương trình tính hệ số tương quan 
    from scipy.stats import pearsonr
    
    #Tính hệ số tương quan Pearson và p_vals tương ứng
    corr = df.corr(method = method)
    pvals = np.ones_like(corr)
    
    m = df.values
    m = np.array(ss.zscore(m))
    
    n = df.shape[1]
    
    out = [pearsonr(m[:, i], m[:, j]) + (i, j) for i, j in itertools.product(range(n), range(n))]
    
    for i in out:
        pvals[i[2], i[3]] = i[1]
    
    pvals = pd.DataFrame(pvals, 
                        columns = corr.columns, 
                        index = corr.index)

    print('Hệ số tương quan Pearson')
    print('='*80)
    print(X.corr())
    print('='*80)
    return corr, pvals

#3
def correlation_network(df = None, 
                        coefthres = 0.0, 
                        pvalthres = 0.05, 
                        font_size = 5, 
                        width = 0.1):
    # Chương trình network
    import networkx as nx

    # 1) Tạo adjacency matrices
    corr, pvals = correlation_matrix(df, method = 'pearson')
    
    # 2) Lọc bỏ diagonal
    np.fill_diagonal(corr.values, 0)
    
    # 3) Lọc bỏ các edges theo ngưỡng r, p
    corr[np.abs(corr) <= coefthres] = 0
    corr[pvals > pvalthres] = 0
    
    # 4) Chuyển adjacency sau khi làm sạch thành graph
    C = nx.from_pandas_adjacency(corr)
    
    # 5) Trích xuất weights (giá trị r của edges) và degrees (số liên kết đi đến 1 node)
    weights = np.array([d['weight'] for s,t,d in C.edges(data=True)])
    degrees = np.array([val for (node, val) in C.degree()])
    
    # 6) Vẽ graph
    pos = nx.spring_layout(C)
    
    edges = nx.draw_networkx_edges(C,pos,
                                   edge_color=weights,
                                   width=width,
                                   edge_cmap=plt.cm.coolwarm)
    
    nodes = nx.draw_networkx(C, pos,
                             width=width,
                             edge_color=weights,
                             node_color=degrees,
                             cmap = plt.cm.Reds,
                             edge_cmap=plt.cm.coolwarm,
                             node_size = 12*(degrees+5),
                             font_size = font_size,
                             )
    plt.show()
    return C

#4
def correlation_heatmap(X):
    '''
    Hàm thực hiện vẽ biểu đồ heatmap thể hiện tương quan từng biến
    # Input: pandas dataframe 
    # Output: heatmap
    '''
    corr = X.corr()
    plt.subplots(figsize=(14,14))
    sns.heatmap(corr,
        mask = np.triu(np.ones_like(corr, dtype=np.bool)), 
        center = 0,
        cmap = plt.cm.coolwarm,
        square = True, 
        linewidths = .5, 
        cbar_kws = {"shrink": .5})
    plt.show()
