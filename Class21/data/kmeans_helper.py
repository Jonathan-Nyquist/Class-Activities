def kmeans(tbl, k, seed):
    """Sort the rows of a two-column table into k clusters.
    Returns a copy of the table with a new 'cluster' column."""
    # Put both columns in standard units so neither one dominates the distance
    x = standard_units(tbl.column(0))
    y = standard_units(tbl.column(1))

    # Start: pick k rows at random to be the first centers
    np.random.seed(seed)
    start_rows = np.random.choice(np.arange(tbl.num_rows), k, replace=False)
    center_x = x.take(start_rows)
    center_y = y.take(start_rows)

    clusters = np.zeros(tbl.num_rows)
    for step in np.arange(50):
        # Step A: every point joins the center it is closest to
        new_clusters = make_array()
        for i in np.arange(tbl.num_rows):
            distances = np.sqrt((x.item(i) - center_x)**2 + (y.item(i) - center_y)**2)
            new_clusters = np.append(new_clusters, np.argmin(distances))

        # Step B: every center moves to the average of its points
        for c in np.arange(k):
            center_x[c] = np.mean(x[new_clusters == c])
            center_y[c] = np.mean(y[new_clusters == c])

        # Stop when no point changed clusters
        if step > 0 and np.all(new_clusters == clusters):
            break
        clusters = new_clusters

    return tbl.with_column('cluster', clusters.astype(int))


def plot_clusters(tbl, title):
    """Scatter plot with each cluster in its own color."""
    tbl.scatter(0, 1, group='cluster')
    plt.title(title)
